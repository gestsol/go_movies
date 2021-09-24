defmodule GoMovieWeb.MResourceMovieController do
  use GoMovieWeb, :controller

  import GoMovie.Auth, only: [restrict_to_admin: 2]

  alias GoMovie.MongoModel.Movie
  alias GoMovie.MongoUtils
  alias GoMovie.Content

  plug :restrict_to_admin when action in [:create, :update, :delete]

  action_fallback GoMovieWeb.FallbackController

  @collection_name "resources_movies"

  def index(conn, params) do
    search = Map.get(params, "search", "")
    fields = Map.get(params, "fields", "") |> String.split(",") |> Enum.reject(&(&1 == ""))

    movies = Movie.get_movies(search, fields)
    json(conn, movies)
  end

  def create(conn, %{"resource_movie" => resource_params}) do
    # Get all image files
    images = Map.take(resource_params, ["thumb_file", "poster_file", "landscape_poster_file"])
    # delete image files so that they are not saved in mongodb
    resource_params =
      Map.drop(resource_params, ["thumb_file", "poster_file", "landscape_poster_file"])

    # Save image files in aws and get s3_url of each image
    images_s3_urls = handle_images_on_create(images)

    resource_params = Map.merge(resource_params, images_s3_urls)

    # Since the data is received as formData, we need to parse array values such as artists and genders.
    # because they come as a string.
    resource_params = MongoUtils.decode_formdata_fields(resource_params, ["artists", "genders"])

    genders = resource_params["genders"]

    resource_params = Map.delete(resource_params, "_id")

    case validate_genders(genders) do
      {:error, message} -> handle_error(conn, 400, message)
      {:ok, _} -> handle_movie_insert(conn, resource_params)
    end
  end

  def handle_images_on_create(images) do
    unless Enum.empty?(images) do
      images_keys = Map.keys(images)

      # Upload each image to aws and return a map with each url
      Enum.reduce(images_keys, %{}, fn img_key, acc ->
        key =
          case img_key do
            "thumb_file" -> "thumb"
            "poster_file" -> "poster_url"
            "landscape_poster_file" -> "landscape_poster_url"
          end

        img_to_upload = Map.get(images, img_key)

        {:ok, s3_url} = Content.upload_asset_to_s3(img_to_upload, "covers")

        Map.put(acc, key, s3_url)
      end)
    else
      %{}
    end
  end

  def show(conn, %{"id" => id}) do
    resources_movie = MongoUtils.get_by_id(id, @collection_name)
    json(conn, resources_movie)
  end

  def update(conn, %{"id" => id, "resource_movie" => resource_params}) do

    images = Map.take(resource_params, ["thumb_file", "poster_file", "landscape_poster_file"])

    resource_params =
      Map.drop(resource_params, ["thumb_file", "poster_file", "landscape_poster_file"])

    images_s3_urls = handle_images_on_create(images)

    resource_params = Map.merge(resource_params, images_s3_urls)

    resource_params = MongoUtils.decode_formdata_fields(resource_params, ["artists", "genders"])

    resource_params = Map.delete(resource_params, "_id")

    if resource_params["genders"] do
      genders = resource_params["genders"]

      case validate_genders(genders) do
        {:error, message} -> handle_error(conn, 400, message)
        {:ok, _} -> handle_movie_update(conn, resource_params, id)
      end
    else
      resource_movie = Movie.update_movie(resource_params, id)
      json(conn, resource_movie)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _} <- Movie.delete_movie(id) do
      Content.delete_movie_playback(id)
      send_resp(conn, :no_content, "")
    end
  end

  def handle_movie_insert(conn, params) do
    # check if genders are valid
    case validate_genders(params["genders"]) do
      {:error, message} ->
        handle_error(conn, 400, message)

      {:ok, db_genders} ->
        resource_movie =
          params
          |> Map.put("genders", db_genders)
          |> MongoUtils.insert_one(@collection_name)

        json(conn, resource_movie)
    end
  end

  def handle_movie_update(conn, params, id) do
    case validate_genders(params["genders"]) do
      {:error, message} ->
        handle_error(conn, 400, message)

      {:ok, db_genders} ->
        resource_movie =
          params
          |> Map.put("genders", db_genders)
          |> MongoUtils.update(@collection_name, id)

        json(conn, resource_movie)
    end
  end

  def validate_genders(genders) do
    error =
      cond do
        is_nil(genders) ->
          "Missing field genders."

        is_list(genders) == false ->
          "Field genders must be of type array."

        length(genders) == 0 ->
          "Field genders is empty."

        is_nil(Enum.find(genders, fn g -> is_binary(g) == false end)) == false ->
          "Field genders must be an array of strings"

        true ->
          nil
      end

    if is_nil(error) do
      valid_genders = MongoUtils.find_in("genders", :name, genders)
      genders_names = valid_genders |> Enum.map(fn g -> g["name"] end)
      invalid_gender = Enum.find(genders, fn g -> g not in genders_names end)

      case is_nil(invalid_gender) do
        true -> {:ok, valid_genders}
        false -> {:error, "Invalid gender: #{invalid_gender}"}
      end
    else
      {:error, error}
    end
  end

  def handle_error(conn, status, error) when is_integer(status) do
    conn
    |> put_status(status)
    |> json(%{error: error})
  end
end

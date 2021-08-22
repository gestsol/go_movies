defmodule GoMovieWeb.MResourceMovieController do
  use GoMovieWeb, :controller

  alias GoMovie.MongoUtils

  action_fallback GoMovieWeb.FallbackController

  @collection_name "resources_movies"

  def index(conn, _params) do
    resources_movies = MongoUtils.find_all(@collection_name)
    json(conn, resources_movies)
  end

  def create(conn, %{"resource_movie" => resource_params}) do
    genders = resource_params["genders"]

    case validate_genders(genders) do
      {:error, message} -> handle_error(conn, 400, message)
      {:ok, _} -> handle_movie_insert(conn, resource_params)
    end
  end

  def show(conn, %{"id" => id}) do
    resources_movie = MongoUtils.get_by_id(id, @collection_name)
    json(conn, resources_movie)
  end

  def update(conn, %{"id" => id, "resource_movie" => resource_params}) do
    if resource_params["genders"] do
      genders = resource_params["genders"]

      case validate_genders(genders) do
        {:error, message} -> handle_error(conn, 400, message)
        {:ok, _} -> handle_movie_insert(conn, resource_params)
      end
    else
      resource_movie = resource_params |> MongoUtils.update(@collection_name, id)
      json(conn, resource_movie)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _} <- MongoUtils.delete(id, @collection_name) do
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

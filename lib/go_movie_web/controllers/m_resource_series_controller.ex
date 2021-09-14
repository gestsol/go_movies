defmodule GoMovieWeb.MResourceSerieController do
  use GoMovieWeb, :controller

  alias GoMovie.MongoUtils
  alias GoMovie.MongoModel.Serie
  alias GoMovie.Content

  import GoMovieWeb.MResourceMovieController, only: [handle_images_on_create: 1]

  action_fallback GoMovieWeb.FallbackController

  @collection_name "resources_series"

  def index(conn, params) do
    search = Map.get(params, "search", "")
    fields = Map.get(params, "fields", "") |> String.split(",") |> Enum.reject(&(&1 == ""))

    series = Serie.get_series(search, fields)
    json(conn, series)
  end

  def create(conn, %{"resource_serie" => resource_params}) do
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
    resource_params =
      MongoUtils.decode_formdata_fields(resource_params, ["artists", "genders", "seasons"])

    genders = resource_params["genders"]

    case MongoUtils.validate_genders(genders) do
      {:error, msg} ->
        conn
        |> put_status(400)
        |> json(%{error: msg})

      {:ok, db_genders} ->
        resource_serie =
          resource_params
          |> Map.put("genders", db_genders)
          |> Serie.handle_serie_insertion()
          |> MongoUtils.insert_one(@collection_name)
          |> Serie.parse_seasons_and_chapters_ids()

        json(conn, resource_serie)
    end
  end

  def show(conn, %{"id" => id}) do
    resources_serie =
      MongoUtils.get_by_id(id, @collection_name)
      |> Serie.parse_seasons_and_chapters_ids()

    json(conn, resources_serie)
  end

  def add_season(conn, %{"season" => season, "serie_id" => serie_id}) do
    case Serie.add_season(season, serie_id) do
      {:ok, season} ->
        json(conn, season)

      {:error, msg} ->
        conn
        |> put_status(400)
        |> json(%{error: msg})
    end
  end

  def update_season(conn, %{"season" => season, "serie_id" => serie_id, "season_id" => season_id}) do
    season = Map.delete(season, "_id")

    case Serie.update_season(season, serie_id, season_id) do
      {:ok, season} ->
        json(conn, season)

      {:error, msg} ->
        conn
        |> put_status(400)
        |> json(%{error: msg})
    end
  end

  def add_chapter(conn, %{"chapter" => chapter, "serie_id" => serie_id, "season_id" => season_id}) do
    # Get all image files
    images = Map.take(chapter, ["thumb_file", "poster_file", "landscape_poster_file"])
    # delete image files so that they are not saved in mongodb
    chapter = Map.drop(chapter, ["thumb_file", "poster_file", "landscape_poster_file"])
    # Save image files in aws and get s3_url of each image
    images_s3_urls = handle_images_on_create(images)

    chapter = Map.merge(chapter, images_s3_urls)

    case Serie.add_chapter(chapter, serie_id, season_id) do
      {:ok, chapter} ->
        json(conn, chapter)

      {:error, msg} ->
        conn
        |> put_status(400)
        |> json(%{error: msg})
    end
  end

  def update_chapter(conn, %{
        "chapter" => chapter,
        "serie_id" => serie_id,
        "season_id" => season_id,
        "chapter_id" => chapter_id
      }) do
    # Get all image files
    images = Map.take(chapter, ["thumb_file", "poster_file", "landscape_poster_file"])
    # delete image files so that they are not saved in mongodb
    chapter = Map.drop(chapter, ["thumb_file", "poster_file", "landscape_poster_file"])
    # Save image files in aws and get s3_url of each image
    images_s3_urls = handle_images_on_create(images)

    chapter = Map.merge(chapter, images_s3_urls)

    chapter = Map.delete(chapter, "_id")

    case Serie.update_series_chapter(chapter, serie_id, season_id, chapter_id) do
      {:ok, updated_chapter} ->
        json(conn, updated_chapter)

      {:error, msg} ->
        conn
        |> put_status(400)
        |> json(%{error: msg})
    end
  end

  def delete_chapter(conn, %{
        "serie_id" => serie_id,
        "season_id" => season_id,
        "chapter_id" => chapter_id
      }) do
    case Serie.delete_chapter(serie_id, season_id, chapter_id) do
      {:ok, _msg} ->
        Content.delete_chapter_playbacks(serie_id, season_id, chapter_id)
        send_resp(conn, 204, "")

      {:error, msg} ->
        conn
        |> put_status(400)
        |> json(%{error: msg})
    end
  end

  def delete_season(conn, %{"serie_id" => serie_id, "season_id" => season_id}) do
    case Serie.delete_season(serie_id, season_id) do
      {:ok, _msg} ->
        Content.delete_season_playbacks(serie_id, season_id)
        send_resp(conn, 204, "")

      {:error, msg} ->
        conn
        |> put_status(400)
        |> json(%{error: msg})
    end
  end

  def update(conn, %{"id" => id, "resource_serie" => resource_params}) do
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
    resource_params =
      MongoUtils.decode_formdata_fields(resource_params, ["artists", "genders", "seasons"])

    resource_params = Map.delete(resource_params, "_id")

    if resource_params["seasons"] do
      handle_season_param_on_update(conn)
    else
      handle_genders_params_on_update(conn, id, resource_params)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _} <- Serie.delete_serie(id) do
      Content.delete_serie_playbacks(id)
      send_resp(conn, :no_content, "")
    end
  end

  def handle_season_param_on_update(conn) do
    conn
    |> put_status(400)
    |> json(%{msg: "Is not allowed to update series seasons."})
  end

  def handle_genders_params_on_update(conn, id, resource_params) do
    genders = resource_params["genders"]

    if genders do
      case MongoUtils.validate_genders(genders) do
        {:error, msg} ->
          conn
          |> put_status(400)
          |> json(%{error: msg})

        {:ok, db_genders} ->
          resource_serie =
            resource_params
            |> Map.put("genders", db_genders)
            |> Serie.update_serie(id)
            |> Serie.parse_seasons_and_chapters_ids()

          json(conn, resource_serie)
      end
    else
      resource_serie =
        resource_params
        |> MongoUtils.update(@collection_name, id)
        |> Serie.parse_seasons_and_chapters_ids()

      json(conn, resource_serie)
    end
  end
end

defmodule GoMovieWeb.MResourceSerieController do
  use GoMovieWeb, :controller

  alias GoMovie.MongoUtils
  alias GoMovie.MongoModel.Serie

  action_fallback GoMovieWeb.FallbackController

  @collection_name "resources_series"

  def index(conn, _params) do
    resources_series =
      MongoUtils.find_all(@collection_name)
      |> Enum.map(&Serie.parse_seasons_and_chapters_ids/1)

    json(conn, resources_series)
  end

  def create(conn, %{"resource_serie" => resource_params}) do
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
        send_resp(conn, 204, "")

      {:error, msg} ->
        conn
        |> put_status(400)
        |> json(%{error: msg})
    end
  end

  def update(conn, %{"id" => id, "resource_serie" => resource_params}) do
    if resource_params["seasons"] do
      handle_season_param_on_update(conn)
    else
      handle_genders_params_on_update(conn, id, resource_params)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _} <- MongoUtils.delete(id, @collection_name) do
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
            |> MongoUtils.update(@collection_name, id)
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

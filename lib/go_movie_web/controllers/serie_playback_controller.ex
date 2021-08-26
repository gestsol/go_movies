defmodule GoMovieWeb.SeriePlaybackController do
  use GoMovieWeb, :controller
  use Filterable.Phoenix.Controller

  import Ecto.Query

  alias GoMovie.Content
  alias GoMovie.Content.SeriePlayback

  action_fallback GoMovieWeb.FallbackController

  filterable do
    @options cast: :string
    @options param: :user_id
    filter user(query, value, _conn) do
      query |> where(user_id: ^value)
    end

    @options cast: :string
    @options param: :serie_id
    filter serie(query, value, _conn) do
      query |> where(serie_id: ^value)
    end

    @options cast: :string
    @options param: :season_id
    filter season(query, value, _conn) do
      query |> where(season_id: ^value)
    end

    @options cast: :string
    @options param: :chapter_id
    filter chapter(query, value, _conn) do
      query |> where(chapter_id: ^value)
    end
  end

  def index(conn, _params) do
    with {:ok, query, _} <- apply_filters(SeriePlayback, conn),
         series_playbacks <- Content.list_series_playbacks(query),
    do: render(conn, "index.json", series_playbacks: series_playbacks)
  end

  def create(conn, %{"serie_playback" => serie_playback_params}) do
    %{
      "user_id" => user_id,
      "serie_id" => serie_id,
      "season_id" => season_id,
      "chapter_id" => chapter_id,
      "seekable" => seekable
    } = serie_playback_params

    playback = Content.get_serie_playback(user_id, serie_id, season_id, chapter_id)

    if is_nil(playback) do
      with {:ok, %SeriePlayback{} = serie_playback} <- Content.create_serie_playback(serie_playback_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.serie_playback_path(conn, :show, serie_playback))
        |> render("show.json", serie_playback: serie_playback)
      end
    else
      with {:ok, %SeriePlayback{} = serie_playback} <-
        Content.update_serie_playback(playback, %{"seekable" => seekable}) do
        render(conn, "show.json", serie_playback: serie_playback)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    serie_playback = Content.get_serie_playback!(id)
    render(conn, "show.json", serie_playback: serie_playback)
  end

  def update(conn, %{"id" => id, "serie_playback" => serie_playback_params}) do
    serie_playback = Content.get_serie_playback!(id)

    with {:ok, %SeriePlayback{} = serie_playback} <- Content.update_serie_playback(serie_playback, serie_playback_params) do
      render(conn, "show.json", serie_playback: serie_playback)
    end
  end

  def delete(conn, %{"id" => id}) do
    serie_playback = Content.get_serie_playback!(id)

    with {:ok, %SeriePlayback{}} <- Content.delete_serie_playback(serie_playback) do
      send_resp(conn, :no_content, "")
    end
  end
end

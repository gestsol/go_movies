defmodule GoMovieWeb.UserMoviePlaybackController do
  use GoMovieWeb, :controller
  use Filterable.Phoenix.Controller

  import Ecto.Query

  alias GoMovie.Content
  alias GoMovie.Content.UserMoviePlayback

  action_fallback GoMovieWeb.FallbackController

  filterable do
    @options cast: :string
    @options param: :user_id
    filter user(query, value, _conn) do
      query |> where(user_id: ^value)
    end
  end

  def index(conn, _params) do
    with {:ok, query, _} <- apply_filters(UserMoviePlayback, conn),
         user_movies_playbacks <- Content.list_user_movies_playbacks(query),
         do: render(conn, "index.json", user_movies_playbacks: user_movies_playbacks)
  end

  def create(conn, %{"user_movie_playback" => user_movie_playback_params}) do
    %{
      "user_id" => user_id,
      "movie_id" => movie_id,
      "seekable" => seekable
    } = user_movie_playback_params

    user_movie_playback = Content.get_movie_playback_by_user_and_movie(user_id, movie_id)

    if is_nil(user_movie_playback) do
      with {:ok, %UserMoviePlayback{} = user_movie_playback} <- Content.create_user_movie_playback(user_movie_playback_params) do
        conn
        |> put_status(:created)
        |> render("show.json", user_movie_playback: user_movie_playback)
      end
    else
      with {:ok, %UserMoviePlayback{} = user_movie_playback} <-
             Content.update_user_movie_playback(user_movie_playback, %{"seekable" => seekable}) do
        render(conn, "show.json", user_movie_playback: user_movie_playback)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    user_movie_playback = Content.get_user_movie_playback!(id)
    render(conn, "show.json", user_movie_playback: user_movie_playback)
  end

  def update(conn, %{"id" => id, "user_movie_playback" => user_movie_playback_params}) do
    user_movie_playback = Content.get_user_movie_playback!(id)

    with {:ok, %UserMoviePlayback{} = user_movie_playback} <-
           Content.update_user_movie_playback(user_movie_playback, user_movie_playback_params) do
      render(conn, "show.json", user_movie_playback: user_movie_playback)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_movie_playback = Content.get_user_movie_playback!(id)

    with {:ok, %UserMoviePlayback{}} <- Content.delete_user_movie_playback(user_movie_playback) do
      send_resp(conn, :no_content, "")
    end
  end
end

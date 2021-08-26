defmodule GoMovieWeb.SeenMoviesController do
  use GoMovieWeb, :controller

  alias GoMovie.Content
  alias GoMovie.Content.SeenMovies

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    seen_movies = Content.list_seen_movies()
    render(conn, "index.json", seen_movies: seen_movies)
  end

  def create(conn, %{"seen_movies" => seen_movies_params}) do
    with {:ok, %SeenMovies{} = seen_movies} <- Content.create_seen_movies(seen_movies_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.seen_movies_path(conn, :show, seen_movies))
      |> render("show.json", seen_movies: seen_movies)
    end
  end

  def show(conn, %{"id" => id}) do
    seen_movies = Content.get_seen_movies!(id)
    render(conn, "show.json", seen_movies: seen_movies)
  end

  def update(conn, %{"id" => id, "seen_movies" => seen_movies_params}) do
    seen_movies = Content.get_seen_movies!(id)

    with {:ok, %SeenMovies{} = seen_movies} <- Content.update_seen_movies(seen_movies, seen_movies_params) do
      render(conn, "show.json", seen_movies: seen_movies)
    end
  end

  def delete(conn, %{"id" => id}) do
    seen_movies = Content.get_seen_movies!(id)

    with {:ok, %SeenMovies{}} <- Content.delete_seen_movies(seen_movies) do
      send_resp(conn, :no_content, "")
    end
  end
end

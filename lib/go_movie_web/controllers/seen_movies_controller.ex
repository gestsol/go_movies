defmodule GoMovieWeb.SeenMoviesController do
  use GoMovieWeb, :controller
  use Filterable.Phoenix.Controller

  import Ecto.Query

  alias GoMovie.Content
  alias GoMovie.Content.SeenMovies

  action_fallback GoMovieWeb.FallbackController

  filterable do
    @options cast: :string
    @options param: :user_id
    filter user(query, value, _conn) do
      query |> where(user_id: ^value)
    end

    @options cast: :string
    @options param: :movie_id
    filter movie(query, value, _conn) do
      query |> where(movie_id: ^value)
    end
  end

  def index(conn, _params) do
    with {:ok, query, _} <- apply_filters(SeenMovies, conn),
         seen_movies <- Content.list_seen_movies(query),
    do: render(conn, "index.json", seen_movies: seen_movies)
  end

  def create(conn, %{"seen_movie" => seen_movies_params}) do
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

  def update(conn, %{"id" => id, "seen_movie" => seen_movies_params}) do
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

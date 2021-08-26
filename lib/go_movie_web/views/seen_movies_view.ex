defmodule GoMovieWeb.SeenMoviesView do
  use GoMovieWeb, :view
  alias GoMovieWeb.SeenMoviesView

  def render("index.json", %{seen_movies: seen_movies}) do
    %{data: render_many(seen_movies, SeenMoviesView, "seen_movies.json")}
  end

  def render("show.json", %{seen_movies: seen_movies}) do
    %{data: render_one(seen_movies, SeenMoviesView, "seen_movies.json")}
  end

  def render("seen_movies.json", %{seen_movies: seen_movies}) do
    %{
      id: seen_movies.id,
      movie_id: seen_movies.movie_id,
      user_id: seen_movies.user_id
    }
  end
end

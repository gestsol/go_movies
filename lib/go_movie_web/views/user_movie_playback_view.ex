defmodule GoMovieWeb.UserMoviePlaybackView do
  use GoMovieWeb, :view
  alias GoMovieWeb.UserMoviePlaybackView

  def render("index.json", %{user_movies_playbacks: user_movies_playbacks}) do
    %{data: render_many(user_movies_playbacks, UserMoviePlaybackView, "user_movie_playback.json")}
  end

  def render("show.json", %{user_movie_playback: user_movie_playback}) do
    %{data: render_one(user_movie_playback, UserMoviePlaybackView, "user_movie_playback.json")}
  end

  def render("user_movie_playback.json", %{user_movie_playback: user_movie_playback}) do
    %{id: user_movie_playback.id,
      seekable: user_movie_playback.seekable,
      duration: user_movie_playback.duration,
      movie_id: user_movie_playback.movie_id,
      user_id: user_movie_playback.user_id,
      progress: Map.get(user_movie_playback, :progress, 0)
    }
  end
end

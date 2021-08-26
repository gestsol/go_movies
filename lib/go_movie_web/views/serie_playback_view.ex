defmodule GoMovieWeb.SeriePlaybackView do
  use GoMovieWeb, :view
  alias GoMovieWeb.SeriePlaybackView

  def render("index.json", %{series_playbacks: series_playbacks}) do
    %{data: render_many(series_playbacks, SeriePlaybackView, "serie_playback.json")}
  end

  def render("show.json", %{serie_playback: serie_playback}) do
    %{data: render_one(serie_playback, SeriePlaybackView, "serie_playback.json")}
  end

  def render("serie_playback.json", %{serie_playback: serie_playback}) do
    %{
      id: serie_playback.id,
      serie_id: serie_playback.serie_id,
      season_id: serie_playback.season_id,
      chapter_id: serie_playback.chapter_id,
      seekable: serie_playback.seekable,
      user_id: serie_playback.user_id
    }
  end
end

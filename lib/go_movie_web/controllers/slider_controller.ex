defmodule GoMovieWeb.SliderController do
  use GoMovieWeb, :controller

  alias GoMovie.Cache.Sliders

  action_fallback GoMovieWeb.FallbackController

  def index_movies(conn, _params) do
    sliders = Sliders.get_movies_sliders()

    json(conn, sliders)
  end

  def update_movies_sliders(conn, %{"movies_sliders" => sliders}) do
    Sliders.add_movies_sliders(sliders)
    sliders = Sliders.get_movies_sliders()

    IO.inspect(sliders)

    json(conn, sliders)
  end

  def index_series(conn, _params) do
    sliders = Sliders.get_series_sliders()

    json(conn, sliders)
  end

  def update_series_sliders(conn, %{"series_sliders" => sliders}) do
    Sliders.add_series_sliders(sliders)
    sliders = Sliders.get_series_sliders()

    json(conn, sliders)
  end
end

defmodule GoMovieWeb.MainSliderView do
  use GoMovieWeb, :view
  alias GoMovieWeb.MainSliderView

  def render("index.json", %{main_sliders: main_sliders}) do
    %{data: render_many(main_sliders, MainSliderView, "main_slider.json")}
  end

  def render("show.json", %{main_slider: main_slider}) do
    %{data: render_one(main_slider, MainSliderView, "main_slider.json")}
  end

  def render("main_slider.json", %{main_slider: main_slider}) do
    %{id: main_slider.id,
      title: main_slider.title,
      description: main_slider.description,
      img_url: main_slider.img_url,
      link_1: main_slider.link_1,
      link_2: main_slider.link_2,
      status: main_slider.status}
  end
end

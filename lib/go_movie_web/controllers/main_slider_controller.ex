defmodule GoMovieWeb.MainSliderController do
  use GoMovieWeb, :controller

  alias GoMovie.Content
  alias GoMovie.Content.MainSlider

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    main_sliders = Content.list_main_sliders()
    render(conn, "index.json", main_sliders: main_sliders)
  end

  def create(conn, %{"main_slider" => main_slider_params}) do
    img = Map.get(main_slider_params, "img")

    with {:ok, img_url} <- Content.upload_asset_to_s3(img, "main_sliders"),
         main_slider_params <- Map.put(main_slider_params, "img_url", img_url),
         {:ok, %MainSlider{} = main_slider} <- Content.create_main_slider(main_slider_params)
    do
      conn
      |> put_status(:created)
      |> render("show.json", main_slider: main_slider)
    end
  end

  def show(conn, %{"id" => id}) do
    main_slider = Content.get_main_slider!(id)
    render(conn, "show.json", main_slider: main_slider)
  end

  def update(conn, %{"id" => id, "main_slider" => main_slider_params}) do
    main_slider = Content.get_main_slider!(id)

    with {:ok, %MainSlider{} = main_slider} <-
           Content.update_main_slider(main_slider, main_slider_params) do
      render(conn, "show.json", main_slider: main_slider)
    end
  end

  def delete(conn, %{"id" => id}) do
    main_slider = Content.get_main_slider!(id)

    with {:ok, %MainSlider{}} <- Content.delete_main_slider(main_slider) do
      send_resp(conn, :no_content, "")
    end
  end
end

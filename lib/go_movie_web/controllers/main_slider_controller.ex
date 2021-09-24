defmodule GoMovieWeb.MainSliderController do
  use GoMovieWeb, :controller

  import GoMovie.Auth, only: [restrict_to_admin: 2]

  alias GoMovie.Content
  alias GoMovie.Content.MainSlider

  plug :restrict_to_admin when action in [:index, :show, :create, :update, :delete]

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    main_sliders = Content.list_main_sliders()
    render(conn, "index.json", main_sliders: main_sliders)
  end

  def create(conn, %{"main_slider" => main_slider_params}) do
    with %{valid?: true} <- MainSlider.changeset(%MainSlider{}, main_slider_params),
          {:ok, img} <- Map.fetch(main_slider_params, "img"),
          {:ok, img_url} <- Content.upload_asset_to_s3(img, "main_sliders"),
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
    img = Map.get(main_slider_params, "img")

    if img do
      handle_update_with_img(conn, id, main_slider_params, img)
    else
      handle_update_without_img(conn, id, main_slider_params)
    end
  end

  def handle_update_with_img(conn, id, main_slider_params, img) do
    main_slider = Content.get_main_slider!(id)

    with %{valid?: true} <- MainSlider.changeset(%MainSlider{}, main_slider_params),
          {:ok, img_url} <- Content.upload_asset_to_s3(img, "main_sliders"),
          main_slider_params <- Map.put(main_slider_params, "img_url", img_url),
          {:ok, %MainSlider{} = main_slider} <- Content.update_main_slider(main_slider, main_slider_params)
    do
      conn
      |> render("show.json", main_slider: main_slider)
    end
  end

  def handle_update_without_img(conn, id, main_slider_params) do
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

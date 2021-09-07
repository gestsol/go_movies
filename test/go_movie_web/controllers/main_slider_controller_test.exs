defmodule GoMovieWeb.MainSliderControllerTest do
  use GoMovieWeb.ConnCase

  alias GoMovie.Content
  alias GoMovie.Content.MainSlider

  @create_attrs %{
    description: "some description",
    img_url: "some img_url",
    link_1: "some link_1",
    link_2: "some link_2",
    status: true,
    title: "some title"
  }
  @update_attrs %{
    description: "some updated description",
    img_url: "some updated img_url",
    link_1: "some updated link_1",
    link_2: "some updated link_2",
    status: false,
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, img_url: nil, link_1: nil, link_2: nil, status: nil, title: nil}

  def fixture(:main_slider) do
    {:ok, main_slider} = Content.create_main_slider(@create_attrs)
    main_slider
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all main_sliders", %{conn: conn} do
      conn = get(conn, Routes.main_slider_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create main_slider" do
    test "renders main_slider when data is valid", %{conn: conn} do
      conn = post(conn, Routes.main_slider_path(conn, :create), main_slider: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.main_slider_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "img_url" => "some img_url",
               "link_1" => "some link_1",
               "link_2" => "some link_2",
               "status" => true,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.main_slider_path(conn, :create), main_slider: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update main_slider" do
    setup [:create_main_slider]

    test "renders main_slider when data is valid", %{conn: conn, main_slider: %MainSlider{id: id} = main_slider} do
      conn = put(conn, Routes.main_slider_path(conn, :update, main_slider), main_slider: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.main_slider_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "img_url" => "some updated img_url",
               "link_1" => "some updated link_1",
               "link_2" => "some updated link_2",
               "status" => false,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, main_slider: main_slider} do
      conn = put(conn, Routes.main_slider_path(conn, :update, main_slider), main_slider: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete main_slider" do
    setup [:create_main_slider]

    test "deletes chosen main_slider", %{conn: conn, main_slider: main_slider} do
      conn = delete(conn, Routes.main_slider_path(conn, :delete, main_slider))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.main_slider_path(conn, :show, main_slider))
      end
    end
  end

  defp create_main_slider(_) do
    main_slider = fixture(:main_slider)
    %{main_slider: main_slider}
  end
end

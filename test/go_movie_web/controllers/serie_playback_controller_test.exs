defmodule GoMovieWeb.SeriePlaybackControllerTest do
  use GoMovieWeb.ConnCase

  alias GoMovie.Content
  alias GoMovie.Content.SeriePlayback

  @create_attrs %{
    chapter_id: "some chapter_id",
    season_id: "some season_id",
    seekable: "120.5",
    serie_id: "some serie_id"
  }
  @update_attrs %{
    chapter_id: "some updated chapter_id",
    season_id: "some updated season_id",
    seekable: "456.7",
    serie_id: "some updated serie_id"
  }
  @invalid_attrs %{chapter_id: nil, season_id: nil, seekable: nil, serie_id: nil}

  def fixture(:serie_playback) do
    {:ok, serie_playback} = Content.create_serie_playback(@create_attrs)
    serie_playback
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all series_playbacks", %{conn: conn} do
      conn = get(conn, Routes.serie_playback_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create serie_playback" do
    test "renders serie_playback when data is valid", %{conn: conn} do
      conn = post(conn, Routes.serie_playback_path(conn, :create), serie_playback: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.serie_playback_path(conn, :show, id))

      assert %{
               "id" => id,
               "chapter_id" => "some chapter_id",
               "season_id" => "some season_id",
               "seekable" => "120.5",
               "serie_id" => "some serie_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.serie_playback_path(conn, :create), serie_playback: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update serie_playback" do
    setup [:create_serie_playback]

    test "renders serie_playback when data is valid", %{conn: conn, serie_playback: %SeriePlayback{id: id} = serie_playback} do
      conn = put(conn, Routes.serie_playback_path(conn, :update, serie_playback), serie_playback: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.serie_playback_path(conn, :show, id))

      assert %{
               "id" => id,
               "chapter_id" => "some updated chapter_id",
               "season_id" => "some updated season_id",
               "seekable" => "456.7",
               "serie_id" => "some updated serie_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, serie_playback: serie_playback} do
      conn = put(conn, Routes.serie_playback_path(conn, :update, serie_playback), serie_playback: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete serie_playback" do
    setup [:create_serie_playback]

    test "deletes chosen serie_playback", %{conn: conn, serie_playback: serie_playback} do
      conn = delete(conn, Routes.serie_playback_path(conn, :delete, serie_playback))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.serie_playback_path(conn, :show, serie_playback))
      end
    end
  end

  defp create_serie_playback(_) do
    serie_playback = fixture(:serie_playback)
    %{serie_playback: serie_playback}
  end
end

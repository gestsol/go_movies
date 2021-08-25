defmodule GoMovieWeb.UserMoviePlaybackControllerTest do
  use GoMovieWeb.ConnCase

  alias GoMovie.Content
  alias GoMovie.Content.UserMoviePlayback

  @create_attrs %{
    movie_id: "some movie_id",
    seekable: "120.5"
  }
  @update_attrs %{
    movie_id: "some updated movie_id",
    seekable: "456.7"
  }
  @invalid_attrs %{movie_id: nil, seekable: nil}

  def fixture(:user_movie_playback) do
    {:ok, user_movie_playback} = Content.create_user_movie_playback(@create_attrs)
    user_movie_playback
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all user_movies_playbacks", %{conn: conn} do
      conn = get(conn, Routes.user_movie_playback_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_movie_playback" do
    test "renders user_movie_playback when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_movie_playback_path(conn, :create), user_movie_playback: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_movie_playback_path(conn, :show, id))

      assert %{
               "id" => id,
               "movie_id" => "some movie_id",
               "seekable" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_movie_playback_path(conn, :create), user_movie_playback: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_movie_playback" do
    setup [:create_user_movie_playback]

    test "renders user_movie_playback when data is valid", %{conn: conn, user_movie_playback: %UserMoviePlayback{id: id} = user_movie_playback} do
      conn = put(conn, Routes.user_movie_playback_path(conn, :update, user_movie_playback), user_movie_playback: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_movie_playback_path(conn, :show, id))

      assert %{
               "id" => id,
               "movie_id" => "some updated movie_id",
               "seekable" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_movie_playback: user_movie_playback} do
      conn = put(conn, Routes.user_movie_playback_path(conn, :update, user_movie_playback), user_movie_playback: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_movie_playback" do
    setup [:create_user_movie_playback]

    test "deletes chosen user_movie_playback", %{conn: conn, user_movie_playback: user_movie_playback} do
      conn = delete(conn, Routes.user_movie_playback_path(conn, :delete, user_movie_playback))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_movie_playback_path(conn, :show, user_movie_playback))
      end
    end
  end

  defp create_user_movie_playback(_) do
    user_movie_playback = fixture(:user_movie_playback)
    %{user_movie_playback: user_movie_playback}
  end
end

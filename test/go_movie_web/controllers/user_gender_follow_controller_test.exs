defmodule GoMovieWeb.UserGenderFollowControllerTest do
  use GoMovieWeb.ConnCase

  alias GoMovie.Content
  alias GoMovie.Content.UserGenderFollow

  @create_attrs %{
    status: 42
  }
  @update_attrs %{
    status: 43
  }
  @invalid_attrs %{status: nil}

  def fixture(:user_gender_follow) do
    {:ok, user_gender_follow} = Content.create_user_gender_follow(@create_attrs)
    user_gender_follow
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all user_genders_follow", %{conn: conn} do
      conn = get(conn, Routes.user_gender_follow_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_gender_follow" do
    test "renders user_gender_follow when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_gender_follow_path(conn, :create), user_gender_follow: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_gender_follow_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_gender_follow_path(conn, :create), user_gender_follow: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_gender_follow" do
    setup [:create_user_gender_follow]

    test "renders user_gender_follow when data is valid", %{conn: conn, user_gender_follow: %UserGenderFollow{id: id} = user_gender_follow} do
      conn = put(conn, Routes.user_gender_follow_path(conn, :update, user_gender_follow), user_gender_follow: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_gender_follow_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_gender_follow: user_gender_follow} do
      conn = put(conn, Routes.user_gender_follow_path(conn, :update, user_gender_follow), user_gender_follow: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_gender_follow" do
    setup [:create_user_gender_follow]

    test "deletes chosen user_gender_follow", %{conn: conn, user_gender_follow: user_gender_follow} do
      conn = delete(conn, Routes.user_gender_follow_path(conn, :delete, user_gender_follow))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_gender_follow_path(conn, :show, user_gender_follow))
      end
    end
  end

  defp create_user_gender_follow(_) do
    user_gender_follow = fixture(:user_gender_follow)
    %{user_gender_follow: user_gender_follow}
  end
end

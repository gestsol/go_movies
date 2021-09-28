defmodule GoMovieWeb.UserSessionControllerTest do
  use GoMovieWeb.ConnCase

  alias GoMovie.Account
  alias GoMovie.Account.UserSession

  @create_attrs %{
    browser: "some browser",
    device: "some device",
    token: "some token"
  }
  @update_attrs %{
    browser: "some updated browser",
    device: "some updated device",
    token: "some updated token"
  }
  @invalid_attrs %{browser: nil, device: nil, token: nil}

  def fixture(:user_session) do
    {:ok, user_session} = Account.create_user_session(@create_attrs)
    user_session
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all user_sessions", %{conn: conn} do
      conn = get(conn, Routes.user_session_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_session" do
    test "renders user_session when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_session_path(conn, :create), user_session: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_session_path(conn, :show, id))

      assert %{
               "id" => id,
               "browser" => "some browser",
               "device" => "some device",
               "token" => "some token"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_session_path(conn, :create), user_session: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_session" do
    setup [:create_user_session]

    test "renders user_session when data is valid", %{conn: conn, user_session: %UserSession{id: id} = user_session} do
      conn = put(conn, Routes.user_session_path(conn, :update, user_session), user_session: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_session_path(conn, :show, id))

      assert %{
               "id" => id,
               "browser" => "some updated browser",
               "device" => "some updated device",
               "token" => "some updated token"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_session: user_session} do
      conn = put(conn, Routes.user_session_path(conn, :update, user_session), user_session: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_session" do
    setup [:create_user_session]

    test "deletes chosen user_session", %{conn: conn, user_session: user_session} do
      conn = delete(conn, Routes.user_session_path(conn, :delete, user_session))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_session_path(conn, :show, user_session))
      end
    end
  end

  defp create_user_session(_) do
    user_session = fixture(:user_session)
    %{user_session: user_session}
  end
end

defmodule GoMovieWeb.UserControllerTest do
  use GoMovieWeb.ConnCase

  alias GoMovie.Account
  alias GoMovie.Account.User

  @create_attrs %{
    address: "some address",
    city: "some city",
    country: "some country",
    email: "some email",
    image_url: "some image_url",
    lastname: "some lastname",
    name: "some name",
    password_hash: "some password_hash",
    phone_number: "some phone_number",
    postal_code: "some postal_code",
    profile_description: "some profile_description",
    sesion_counter: 42,
    status: "some status"
  }
  @update_attrs %{
    address: "some updated address",
    city: "some updated city",
    country: "some updated country",
    email: "some updated email",
    image_url: "some updated image_url",
    lastname: "some updated lastname",
    name: "some updated name",
    password_hash: "some updated password_hash",
    phone_number: "some updated phone_number",
    postal_code: "some updated postal_code",
    profile_description: "some updated profile_description",
    sesion_counter: 43,
    status: "some updated status"
  }
  @invalid_attrs %{address: nil, city: nil, country: nil, email: nil, image_url: nil, lastname: nil, name: nil, password_hash: nil, phone_number: nil, postal_code: nil, profile_description: nil, sesion_counter: nil, status: nil}

  def fixture(:user) do
    {:ok, user} = Account.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some address",
               "city" => "some city",
               "country" => "some country",
               "email" => "some email",
               "image_url" => "some image_url",
               "lastname" => "some lastname",
               "name" => "some name",
               "password_hash" => "some password_hash",
               "phone_number" => "some phone_number",
               "postal_code" => "some postal_code",
               "profile_description" => "some profile_description",
               "sesion_counter" => 42,
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some updated address",
               "city" => "some updated city",
               "country" => "some updated country",
               "email" => "some updated email",
               "image_url" => "some updated image_url",
               "lastname" => "some updated lastname",
               "name" => "some updated name",
               "password_hash" => "some updated password_hash",
               "phone_number" => "some updated phone_number",
               "postal_code" => "some updated postal_code",
               "profile_description" => "some updated profile_description",
               "sesion_counter" => 43,
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end

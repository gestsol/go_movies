defmodule GoMovieWeb.ResourceGenderControllerTest do
  use GoMovieWeb.ConnCase

  alias GoMovie.Content
  alias GoMovie.Content.ResourceGender

  @create_attrs %{
    status: 42
  }
  @update_attrs %{
    status: 43
  }
  @invalid_attrs %{status: nil}

  def fixture(:resource_gender) do
    {:ok, resource_gender} = Content.create_resource_gender(@create_attrs)
    resource_gender
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all resource_genders", %{conn: conn} do
      conn = get(conn, Routes.resource_gender_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create resource_gender" do
    test "renders resource_gender when data is valid", %{conn: conn} do
      conn = post(conn, Routes.resource_gender_path(conn, :create), resource_gender: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.resource_gender_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.resource_gender_path(conn, :create), resource_gender: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update resource_gender" do
    setup [:create_resource_gender]

    test "renders resource_gender when data is valid", %{conn: conn, resource_gender: %ResourceGender{id: id} = resource_gender} do
      conn = put(conn, Routes.resource_gender_path(conn, :update, resource_gender), resource_gender: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.resource_gender_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, resource_gender: resource_gender} do
      conn = put(conn, Routes.resource_gender_path(conn, :update, resource_gender), resource_gender: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete resource_gender" do
    setup [:create_resource_gender]

    test "deletes chosen resource_gender", %{conn: conn, resource_gender: resource_gender} do
      conn = delete(conn, Routes.resource_gender_path(conn, :delete, resource_gender))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.resource_gender_path(conn, :show, resource_gender))
      end
    end
  end

  defp create_resource_gender(_) do
    resource_gender = fixture(:resource_gender)
    %{resource_gender: resource_gender}
  end
end

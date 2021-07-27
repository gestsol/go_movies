defmodule GoMovieWeb.ResourceTypeControllerTest do
  use GoMovieWeb.ConnCase

  alias GoMovie.Content
  alias GoMovie.Content.ResourceType

  @create_attrs %{
    description: "some description",
    name: "some name",
    status: 42
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    status: 43
  }
  @invalid_attrs %{description: nil, name: nil, status: nil}

  def fixture(:resource_type) do
    {:ok, resource_type} = Content.create_resource_type(@create_attrs)
    resource_type
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all resource_types", %{conn: conn} do
      conn = get(conn, Routes.resource_type_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create resource_type" do
    test "renders resource_type when data is valid", %{conn: conn} do
      conn = post(conn, Routes.resource_type_path(conn, :create), resource_type: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.resource_type_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "name" => "some name",
               "status" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.resource_type_path(conn, :create), resource_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update resource_type" do
    setup [:create_resource_type]

    test "renders resource_type when data is valid", %{conn: conn, resource_type: %ResourceType{id: id} = resource_type} do
      conn = put(conn, Routes.resource_type_path(conn, :update, resource_type), resource_type: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.resource_type_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "name" => "some updated name",
               "status" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, resource_type: resource_type} do
      conn = put(conn, Routes.resource_type_path(conn, :update, resource_type), resource_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete resource_type" do
    setup [:create_resource_type]

    test "deletes chosen resource_type", %{conn: conn, resource_type: resource_type} do
      conn = delete(conn, Routes.resource_type_path(conn, :delete, resource_type))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.resource_type_path(conn, :show, resource_type))
      end
    end
  end

  defp create_resource_type(_) do
    resource_type = fixture(:resource_type)
    %{resource_type: resource_type}
  end
end

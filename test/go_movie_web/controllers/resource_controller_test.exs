defmodule GoMovieWeb.ResourceControllerTest do
  use GoMovieWeb.ConnCase

  alias GoMovie.Content
  alias GoMovie.Content.Resource

  @create_attrs %{
    average: "120.5",
    chapter: 42,
    description: "some description",
    duration: 42,
    name: "some name",
    poster_url: "some poster_url",
    season: 42,
    status: 42,
    trailer_url: "some trailer_url",
    url: "some url",
    year: 42
  }
  @update_attrs %{
    average: "456.7",
    chapter: 43,
    description: "some updated description",
    duration: 43,
    name: "some updated name",
    poster_url: "some updated poster_url",
    season: 43,
    status: 43,
    trailer_url: "some updated trailer_url",
    url: "some updated url",
    year: 43
  }
  @invalid_attrs %{average: nil, chapter: nil, description: nil, duration: nil, name: nil, poster_url: nil, season: nil, status: nil, trailer_url: nil, url: nil, year: nil}

  def fixture(:resource) do
    {:ok, resource} = Content.create_resource(@create_attrs)
    resource
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all resources", %{conn: conn} do
      conn = get(conn, Routes.resource_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create resource" do
    test "renders resource when data is valid", %{conn: conn} do
      conn = post(conn, Routes.resource_path(conn, :create), resource: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.resource_path(conn, :show, id))

      assert %{
               "id" => id,
               "average" => "120.5",
               "chapter" => 42,
               "description" => "some description",
               "duration" => 42,
               "name" => "some name",
               "poster_url" => "some poster_url",
               "season" => 42,
               "status" => 42,
               "trailer_url" => "some trailer_url",
               "url" => "some url",
               "year" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.resource_path(conn, :create), resource: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update resource" do
    setup [:create_resource]

    test "renders resource when data is valid", %{conn: conn, resource: %Resource{id: id} = resource} do
      conn = put(conn, Routes.resource_path(conn, :update, resource), resource: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.resource_path(conn, :show, id))

      assert %{
               "id" => id,
               "average" => "456.7",
               "chapter" => 43,
               "description" => "some updated description",
               "duration" => 43,
               "name" => "some updated name",
               "poster_url" => "some updated poster_url",
               "season" => 43,
               "status" => 43,
               "trailer_url" => "some updated trailer_url",
               "url" => "some updated url",
               "year" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, resource: resource} do
      conn = put(conn, Routes.resource_path(conn, :update, resource), resource: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete resource" do
    setup [:create_resource]

    test "deletes chosen resource", %{conn: conn, resource: resource} do
      conn = delete(conn, Routes.resource_path(conn, :delete, resource))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.resource_path(conn, :show, resource))
      end
    end
  end

  defp create_resource(_) do
    resource = fixture(:resource)
    %{resource: resource}
  end
end

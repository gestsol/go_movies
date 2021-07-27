defmodule GoMovieWeb.ResourceTypeController do
  use GoMovieWeb, :controller

  alias GoMovie.Content
  alias GoMovie.Content.ResourceType

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    resource_types = Content.list_resource_types()
    render(conn, "index.json", resource_types: resource_types)
  end

  def create(conn, %{"resource_type" => resource_type_params}) do
    with {:ok, %ResourceType{} = resource_type} <- Content.create_resource_type(resource_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.resource_type_path(conn, :show, resource_type))
      |> render("show.json", resource_type: resource_type)
    end
  end

  def show(conn, %{"id" => id}) do
    resource_type = Content.get_resource_type!(id)
    render(conn, "show.json", resource_type: resource_type)
  end

  def update(conn, %{"id" => id, "resource_type" => resource_type_params}) do
    resource_type = Content.get_resource_type!(id)

    with {:ok, %ResourceType{} = resource_type} <- Content.update_resource_type(resource_type, resource_type_params) do
      render(conn, "show.json", resource_type: resource_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    resource_type = Content.get_resource_type!(id)

    with {:ok, %ResourceType{}} <- Content.delete_resource_type(resource_type) do
      send_resp(conn, :no_content, "")
    end
  end
end

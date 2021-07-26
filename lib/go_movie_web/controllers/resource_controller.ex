defmodule GoMovieWeb.ResourceController do
  use GoMovieWeb, :controller

  alias GoMovie.Content
  alias GoMovie.Content.Resource

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    resources = Content.list_resources()
    render(conn, "index.json", resources: resources)
  end

  def create(conn, %{"resource" => resource_params}) do
    with {:ok, %Resource{} = resource} <- Content.create_resource(resource_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.resource_path(conn, :show, resource))
      |> render("show.json", resource: resource)
    end
  end

  def show(conn, %{"id" => id}) do
    resource = Content.get_resource!(id)
    render(conn, "show.json", resource: resource)
  end

  def update(conn, %{"id" => id, "resource" => resource_params}) do
    resource = Content.get_resource!(id)

    with {:ok, %Resource{} = resource} <- Content.update_resource(resource, resource_params) do
      render(conn, "show.json", resource: resource)
    end
  end

  def delete(conn, %{"id" => id}) do
    resource = Content.get_resource!(id)

    with {:ok, %Resource{}} <- Content.delete_resource(resource) do
      send_resp(conn, :no_content, "")
    end
  end
end

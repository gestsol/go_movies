defmodule GoMovieWeb.ResourceController do
  use GoMovieWeb, :controller

  alias GoMovie.Content
  alias GoMovie.Content.Resource

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    #resources = Content.list_resources()

    resources_movies = Mongo.find(:mongo, "resources_movies", %{})

    resources_movies
    |> Enum.to_list()
    |> IO.inspect

    json(conn, %{resources_movies: "test"})

   # render(conn, "index.json", resources: resources)
  end

  def create(conn, %{"resource_movie" => resource_params}) do

    IO.inspect(resource_params)

    # GENERATE SEQUENCE ID
    {:ok , counter} = Mongo.find_one_and_update(:mongo, "counters", %{_id: "resource_id" }, %{"$inc": %{sequence_value: 1}})
    resource_merge = Map.merge(resource_params, %{id: counter["sequence_value"] })

    IO.inspect(counter)
    IO.inspect(resource_merge)


    Mongo.insert_one(:mongo, "resources_movies", %{ resource_params: resource_params, id: counter["sequence_value"]})

      # conn
      # |> put_status(:created)
      # |> put_resp_header("location", Routes.resource_path(conn, :show, resource))
      # |> render("show.json", resource: resource)
      send_resp(conn, :no_content, "")
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

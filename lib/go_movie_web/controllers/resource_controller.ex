defmodule GoMovieWeb.ResourceController do
  use GoMovieWeb, :controller

  alias GoMovie.Content
  alias GoMovie.Content.Resource

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    resources_movies = Mongo.find(:mongo, "resources_movies", %{})

    resources_movies_filtered = resources_movies
    |> Enum.to_list()
    |> Enum.map(fn x ->
      Map.delete(x, "_id")
    end )
    |> IO.inspect()

    json(conn, resources_movies_filtered)

  end

  def create(conn, %{"resource_movie" => resource_params}) do

    # GENERATE SEQUENCE ID
    {:ok , counter} = Mongo.find_one_and_update(:mongo, "counters", %{_id: "resource_id" }, %{"$inc": %{sequence_value: 1}})
    resource_merge = Map.merge(resource_params, %{id: counter["sequence_value"] })
    IO.inspect(counter)

    #{:ok, resource_movie }  = Mongo.insert_one(:mongo, "resources_movies", %{ resource_params: resource_params, id: counter["sequence_value"]})
    {:ok, resource_movie }  = Mongo.insert_one(:mongo, "resources_movies", resource_merge)

    IO.inspect(resource_movie)

    resource_movie
    |> Enum.map()
    |> IO.inspect()

    send_resp(conn, :no_content, "")
   # json(conn, resources_movie |> Map.delete("_id"))
   #json(conn, resource_movie |> Map.delete("_id"))
  end

  def show(conn, %{"id" => id}) do
    resources_movie = Mongo.find_one(:mongo, "resources_movies", %{id: String.to_integer(id)})
    json(conn, resources_movie |> Map.delete("_id"))
  end

  def update(conn, %{"id" => id, "resource" => resource_params}) do
    resource = Content.get_resource!(id)

  end

  def delete(conn, %{"id" => id}) do
    {:ok, result} = Mongo.delete_one(:mongo, "resources_movies", %{id: String.to_integer(id)})
    IO.inspect( result)
    send_resp(conn, :no_content, "")

    #json(conn, %{"result": result["acknowledged"]})
  end

end

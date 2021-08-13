defmodule GoMovieWeb.ResourceController do
  use GoMovieWeb, :controller


  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    resources_movies = Mongo.find(:mongo, "resources_movies", %{})

    resources_movies_filtered = resources_movies
    |> Enum.map(fn x -> Map.delete(x, "_id") end)

    json(conn, resources_movies_filtered)
  end

  def create(conn, %{"resource_movie" => resource_params}) do

    # GENERATE SEQUENCE ID
    {:ok , counter} = Mongo.find_one_and_update(:mongo, "counters", %{_id: "resource_id" }, %{"$inc": %{sequence_value: 1}})
    resource_merge = Map.merge(resource_params, %{"id_resource" => counter["sequence_value"] })

    {:ok, resource_movie }  = Mongo.insert_one(:mongo, "resources_movies", resource_merge)
    #IO.inspect(resource_movie)

    resources_movie_get = Mongo.find_one(:mongo, "resources_movies", %{id_resource: counter["sequence_value"]})

    json(conn, resources_movie_get |> Map.delete("_id"))
  end

  def show(conn, %{"id" => id}) do
    resources_movie = Mongo.find_one(:mongo, "resources_movies", %{id_resource: String.to_integer(id)})
    json(conn, resources_movie |> Map.delete("_id"))
  end

  def update(conn, %{"id" => id, "resource_movie" => resource_params}) do
    {:ok, resource_movie} = Mongo.find_one_and_update(:mongo, "resources_movies", %{id_resource: String.to_integer(id)}, %{"$set": resource_params})
   # IO.inspect(resource_movie)

    resources_movie_get = Mongo.find_one(:mongo, "resources_movies", %{id_resource: String.to_integer(id)})

    json(conn, resources_movie_get |> Map.delete("_id"))
  end

  def delete(conn, %{"id" => id}) do
    {:ok, result} = Mongo.delete_one(:mongo, "resources_movies", %{id_resource: String.to_integer(id)})
    #IO.inspect( result)

    send_resp(conn, :no_content, "")
  end

end

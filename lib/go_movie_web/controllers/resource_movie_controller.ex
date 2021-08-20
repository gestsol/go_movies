defmodule GoMovieWeb.ResourceMovieController do
  use GoMovieWeb, :controller

  alias GoMovie.MongoUtils

  action_fallback GoMovieWeb.FallbackController

  @collection_name "resources_movies"

  def index(conn, _params) do
    resources_movies = MongoUtils.find_all(@collection_name)
    json(conn, resources_movies)
  end

  def create(conn, %{"resource_movie" => resource_params}) do
    resource_movie = resource_params |> MongoUtils.insert_one(@collection_name)
    json(conn, resource_movie)
  end

  def show(conn, %{"id" => id}) do
    resources_movie = MongoUtils.get_by_id(id, @collection_name)
    json(conn, resources_movie)
  end

  def update(conn, %{"id" => id, "resource_movie" => resource_params}) do
    resource_movie = resource_params |> MongoUtils.update(@collection_name, id)
    json(conn, resource_movie)
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _} <- MongoUtils.delete(id, @collection_name) do
      send_resp(conn, :no_content, "")
    end
  end

end

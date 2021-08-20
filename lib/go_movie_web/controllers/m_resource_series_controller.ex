defmodule GoMovieWeb.MResourceSerieController do
  use GoMovieWeb, :controller

  alias GoMovie.MongoUtils

  action_fallback GoMovieWeb.FallbackController

  @collection_name "resources_series"

  def index(conn, _params) do
    resources_series = MongoUtils.find_all(@collection_name)
    json(conn, resources_series)
  end

  def create(conn, %{"resource_serie" => resource_params}) do
    resource_serie = resource_params |> MongoUtils.insert_one(@collection_name)
    json(conn, resource_serie)
  end

  def show(conn, %{"id" => id}) do
    resources_serie = MongoUtils.get_by_id(id, @collection_name)
    json(conn, resources_serie)
  end

  def update(conn, %{"id" => id, "resource_serie" => resource_params}) do
    resource_serie = resource_params |> MongoUtils.update(@collection_name, id)
    json(conn, resource_serie)
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _} <- MongoUtils.delete(id, @collection_name) do
      send_resp(conn, :no_content, "")
    end
  end

end

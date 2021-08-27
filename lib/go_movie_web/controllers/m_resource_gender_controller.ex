defmodule GoMovieWeb.MResourceGenderController do
  use GoMovieWeb, :controller

  alias GoMovie.MongoUtils

  action_fallback GoMovieWeb.FallbackController

  @collection_name "genders"

  def index(conn, _params) do
    resources_genders = MongoUtils.find_all(@collection_name)
    json(conn, resources_genders)
  end

  def create(conn, %{"gender" => resource_params}) do
    resource_params = Map.delete(resource_params, "_id")
    resource_gender = resource_params |> MongoUtils.insert_one(@collection_name)
    json(conn, resource_gender)
  end

  def show(conn, %{"id" => id}) do
    resources_gender = MongoUtils.get_by_id(id, @collection_name)
    json(conn, resources_gender)
  end

  def update(conn, %{"id" => id, "gender" => resource_params}) do
    resource_params = Map.delete(resource_params, "_id")
    resource_gender = resource_params |> MongoUtils.update(@collection_name, id)
    json(conn, resource_gender)
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _} <- MongoUtils.delete(id, @collection_name) do
      send_resp(conn, :no_content, "")
    end
  end
end

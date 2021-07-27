defmodule GoMovieWeb.ResourceTypeView do
  use GoMovieWeb, :view
  alias GoMovieWeb.ResourceTypeView

  def render("index.json", %{resource_types: resource_types}) do
    %{resource_types: render_many(resource_types, ResourceTypeView, "resource_type.json")}
  end

  def render("show.json", %{resource_type: resource_type}) do
    %{resource_type: render_one(resource_type, ResourceTypeView, "resource_type.json")}
  end

  def render("resource_type.json", %{resource_type: resource_type}) do
    %{
      resource_type_id: resource_type.resource_type_id,
      name: resource_type.name,
      description: resource_type.description,
      status: resource_type.status
    }
  end
end

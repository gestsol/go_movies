defmodule GoMovieWeb.ResourceView do
  use GoMovieWeb, :view
  alias GoMovieWeb.ResourceView

  def render("index.json", %{resources: resources}) do
    %{resources: render_many(resources, ResourceView, "resource.json")}
  end

  def render("show.json", %{resource: resource}) do
    %{resource: render_one(resource, ResourceView, "resource.json")}
  end

  def render("resource.json", %{resource: resource}) do
    %{
      resource_id: resource.resource_id,
      name: resource.name,
      description: resource.description,
      duration: resource.duration,
      year: resource.year,
      url: resource.url,
      trailer_url: resource.trailer_url,
      poster_url: resource.poster_url,
      status: resource.status,
      score_average: resource.score_average,
      season: resource.season,
      chapter: resource.chapter,
      parent_resource_id: resource.parent_resource_id
    }
  end
end

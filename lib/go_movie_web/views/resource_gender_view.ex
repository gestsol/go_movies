defmodule GoMovieWeb.ResourceGenderView do
  use GoMovieWeb, :view
  alias GoMovieWeb.ResourceGenderView

  def render("index.json", %{resource_genders: resource_genders}) do
    %{resource_genders: render_many(resource_genders, ResourceGenderView, "resource_gender.json")}
  end

  def render("show.json", %{resource_gender: resource_gender}) do
    %{resource_gender: render_one(resource_gender, ResourceGenderView, "resource_gender.json")}
  end

  def render("resource_gender.json", %{resource_gender: resource_gender}) do
    %{
      gender_id: resource_gender.gender_id,
      resource_id: resource_gender.resource_id,
      status: resource_gender.status
    }
  end
end

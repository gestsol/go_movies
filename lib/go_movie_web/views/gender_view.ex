defmodule GoMovieWeb.GenderView do
  use GoMovieWeb, :view
  alias GoMovieWeb.GenderView

  def render("index.json", %{genders: genders}) do
    %{genders: render_many(genders, GenderView, "gender.json")}
  end

  def render("show.json", %{gender: gender}) do
    %{gender: render_one(gender, GenderView, "gender.json")}
  end

  def render("gender.json", %{gender: gender}) do
    %{
      gender_id: gender.gender_id,
      name: gender.name,
      description: gender.description,
      status: gender.status
    }
  end
end

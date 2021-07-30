defmodule GoMovieWeb.UserGenderFollowView do
  use GoMovieWeb, :view
  alias GoMovieWeb.UserGenderFollowView

  def render("index.json", %{user_genders_follow: user_genders_follow}) do
    %{user_genders_follow: render_many(user_genders_follow, UserGenderFollowView, "user_gender_follow.json")}
  end

  def render("show.json", %{user_gender_follow: user_gender_follow}) do
    %{user_gender_follow: render_one(user_gender_follow, UserGenderFollowView, "user_gender_follow.json")}
  end

  def render("user_gender_follow.json", %{user_gender_follow: user_gender_follow}) do
    %{
      status: user_gender_follow.status,
      user_id: user_gender_follow.user_id,
      gender_id: user_gender_follow.gender_id
    }
  end
end

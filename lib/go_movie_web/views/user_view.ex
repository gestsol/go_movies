defmodule GoMovieWeb.UserView do
  use GoMovieWeb, :view
  alias GoMovieWeb.UserView

  def render("index.json", %{users: users}) do
    %{users: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      user_id: user.user_id,
      name: user.name,
      lastname: user.lastname,
      email: user.email,
      image_url: user.image_url,
      status: user.status,
      phone_number: user.phone_number,
      profile_description: user.profile_description,
      country: user.country,
      city: user.city,
      address: user.address,
      postal_code: user.postal_code,
      sesion_counter: user.sesion_counter,
      role_id: user.role_id,
      google_auth_id: user.google_auth_id,
      facebook_auth_id: user.facebook_auth_id
    }
  end
end

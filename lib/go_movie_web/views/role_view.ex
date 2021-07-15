defmodule GoMovieWeb.RoleView do
  use GoMovieWeb, :view
  alias GoMovieWeb.RoleView

  def render("index.json", %{roles: roles}) do
    %{roles: render_many(roles, RoleView, "role.json")}
  end

  def render("show.json", %{role: role}) do
    %{role: render_one(role, RoleView, "role.json")}
  end

  def render("role.json", %{role: role}) do
    %{
      role_id: role.role_id,
      name: role.name,
      description: role.description,
      status: role.status
    }
  end
end

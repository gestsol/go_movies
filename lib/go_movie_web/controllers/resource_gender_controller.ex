defmodule GoMovieWeb.ResourceGenderController do
  use GoMovieWeb, :controller

  alias GoMovie.Content
  alias GoMovie.Content.ResourceGender

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    resource_genders = Content.list_resource_genders()
    render(conn, "index.json", resource_genders: resource_genders)
  end

  def create(conn, %{"resource_gender" => resource_gender_params}) do
    with {:ok, %ResourceGender{} = resource_gender} <- Content.create_resource_gender(resource_gender_params) do
      conn
      |> put_status(:created)
      |> render("show.json", resource_gender: resource_gender)
    end
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"resource_id" => resource_id, "gender_id" => gender_id}) do
    resource_gender = Content.get_resource_gender!(resource_id, gender_id)
    render(conn, "show.json", resource_gender: resource_gender)
  end

  def update(conn, %{"resource_id" => resource_id, "gender_id" => gender_id, "resource_gender" => resource_gender_params}) do
    resource_gender = Content.get_resource_gender!(resource_id, gender_id)

    with {:ok, %ResourceGender{} = resource_gender} <- Content.update_resource_gender(resource_gender, resource_gender_params) do
      render(conn, "show.json", resource_gender: resource_gender)
    end
  end

  def delete(conn, %{"resource_id" => resource_id, "gender_id" => gender_id}) do
    resource_gender = Content.get_resource_gender!(resource_id, gender_id)

    with {:ok, %ResourceGender{}} <- Content.delete_resource_gender(resource_gender) do
      send_resp(conn, :no_content, "")
    end
  end
end

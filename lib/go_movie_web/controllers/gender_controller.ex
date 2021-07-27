defmodule GoMovieWeb.GenderController do
  use GoMovieWeb, :controller

  alias GoMovie.Content
  alias GoMovie.Content.Gender

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    genders = Content.list_genders()
    render(conn, "index.json", genders: genders)
  end

  def create(conn, %{"gender" => gender_params}) do
    with {:ok, %Gender{} = gender} <- Content.create_gender(gender_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.gender_path(conn, :show, gender))
      |> render("show.json", gender: gender)
    end
  end

  def show(conn, %{"id" => id}) do
    gender = Content.get_gender!(id)
    render(conn, "show.json", gender: gender)
  end

  def update(conn, %{"id" => id, "gender" => gender_params}) do
    gender = Content.get_gender!(id)

    with {:ok, %Gender{} = gender} <- Content.update_gender(gender, gender_params) do
      render(conn, "show.json", gender: gender)
    end
  end

  def delete(conn, %{"id" => id}) do
    gender = Content.get_gender!(id)

    with {:ok, %Gender{}} <- Content.delete_gender(gender) do
      send_resp(conn, :no_content, "")
    end
  end
end

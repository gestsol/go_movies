defmodule GoMovieWeb.UserGenderFollowController do
  use GoMovieWeb, :controller

  alias GoMovie.Content
  alias GoMovie.Content.UserGenderFollow

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    user_genders_follow = Content.list_user_genders_follow()
    render(conn, "index.json", user_genders_follow: user_genders_follow)
  end

  def create(conn, %{"user_gender_follow" => user_gender_follow_params}) do
    with {:ok, %UserGenderFollow{} = user_gender_follow} <- Content.create_user_gender_follow(user_gender_follow_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user_gender_follow: user_gender_follow)
    end
  end

  def show(conn, %{"user_id" => user_id, "gender_id" => gender_id}) do
    user_gender_follow = Content.get_user_gender_follow!(user_id, gender_id)
    render(conn, "show.json", user_gender_follow: user_gender_follow)
  end

  def update(conn, %{"user_id" => user_id, "gender_id" => gender_id, "user_gender_follow" => user_gender_follow_params}) do
    user_gender_follow = Content.get_user_gender_follow!(user_id, gender_id)

    with {:ok, %UserGenderFollow{} = user_gender_follow} <- Content.update_user_gender_follow(user_gender_follow, user_gender_follow_params) do
      render(conn, "show.json", user_gender_follow: user_gender_follow)
    end
  end

  def delete(conn, %{"user_id" => user_id, "gender_id" => gender_id}) do
    user_gender_follow = Content.get_user_gender_follow!(user_id, gender_id)

    with {:ok, %UserGenderFollow{}} <- Content.delete_user_gender_follow(user_gender_follow) do
      send_resp(conn, :no_content, "")
    end
  end
end

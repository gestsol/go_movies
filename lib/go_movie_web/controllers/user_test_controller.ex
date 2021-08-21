defmodule GoMovieWeb.UserTestController do
  use GoMovieWeb, :controller

  alias GoMovie.User

  action_fallback GoMovieWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with user <- User.create_user(user_params) do
      conn
      |> put_status(:created)
      |> json(user)
    end
  end
end

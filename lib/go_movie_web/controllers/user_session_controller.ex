defmodule GoMovieWeb.UserSessionController do
  use GoMovieWeb, :controller

  import GoMovie.Auth, only: [restrict_to_admin: 2]

  alias GoMovie.Account
  alias GoMovie.Account.UserSession

  plug :restrict_to_admin when action in [:create, :index, :show, :update, :delete]

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    IO.inspect(conn.private.guardian_default_token)
    user_sessions = Account.list_user_sessions()
    render(conn, "index.json", user_sessions: user_sessions)
  end

  def create(conn, %{"user_session" => user_session_params}) do
    with {:ok, %UserSession{} = user_session} <- Account.create_user_session(user_session_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_session_path(conn, :show, user_session))
      |> render("show.json", user_session: user_session)
    end
  end

  def show(conn, %{"id" => id}) do
    user_session = Account.get_user_session!(id)
    render(conn, "show.json", user_session: user_session)
  end

  def update(conn, %{"id" => id, "user_session" => user_session_params}) do
    user_session = Account.get_user_session!(id)

    with {:ok, %UserSession{} = user_session} <- Account.update_user_session(user_session, user_session_params) do
      render(conn, "show.json", user_session: user_session)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_session = Account.get_user_session!(id)

    with {:ok, %UserSession{}} <- Account.delete_user_session(user_session) do
      send_resp(conn, :no_content, "")
    end
  end
end

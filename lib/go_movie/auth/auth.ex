defmodule GoMovie.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias GoMovie.Account

  def restrict_to_admin(conn, _opts) do
    user = get_logged_user(conn)
    if user.role.name == "admin" do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "You are not allowed to access this route."})
      |> halt()
    end
  end

  def sign_in(%{"email" => email, "password" => password}) do
    case Account.authenticate_user(email, password) do
      {:ok, user} -> log_in_user(user)
      {:error, message} -> {:error, message}
    end
  end

  def restrict_to_role(user, role) do
    if user.role.name == role do
      {:ok, user}
    else
      {:error, :unauthorized}
    end
  end

  def get_logged_user(%{private: private}) do
    Map.fetch!(private, :guardian_default_resource)
  end

  def validate_user_sessions(user) do
    sessions = Account.get_user_sessions_count(user.user_id)
    if sessions < 3 do
      {:ok, user}
    else
      {:error, :session_limit}
    end
  end

  def log_in_user(user) do
    case validate_user_sessions(user) do
      {:ok, user} ->
        {:ok, token, _claims} = GoMovie.Auth.Guardian.encode_and_sign(user)
        {:ok, Map.merge(user, %{token: token})}
      {:error, message} -> {:error, message}
    end
  end
end

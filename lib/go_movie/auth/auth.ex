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
      {:ok, user} ->
        {:ok, token, _claims} = GoMovie.Auth.Guardian.encode_and_sign(user)
        {:ok, Map.merge(user, %{token: token})}

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

end

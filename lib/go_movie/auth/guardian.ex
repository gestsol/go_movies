defmodule GoMovie.Auth.Guardian do
  use Guardian, otp_app: :go_movie

  alias GoMovie.Account

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.user_id)}
  end

  def resource_from_claims(%{"sub" => user_id}) do
    user = Account.get_user!(user_id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end

defmodule GoMovie.User do

  alias Mongux.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Mongux.Repo.insert_one()
  end

end

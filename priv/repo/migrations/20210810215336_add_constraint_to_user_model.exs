defmodule GoMovie.Repo.Migrations.AddConstraintToUserModel do
  use Ecto.Migration

  def change do
    create unique_index(:users, :email)
    create unique_index(:users, :google_auth_id)
  end
end

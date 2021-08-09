defmodule GoMovie.Repo.Migrations.AddFieldGoogleAuthIdToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :google_auth_id, :string
    end
  end
end

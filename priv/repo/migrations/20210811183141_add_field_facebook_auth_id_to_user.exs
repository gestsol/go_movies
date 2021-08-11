defmodule GoMovie.Repo.Migrations.AddFieldFacebookAuthIdToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :facebook_auth_id, :string
    end
    create unique_index(:users, :facebook_auth_id)
  end
end

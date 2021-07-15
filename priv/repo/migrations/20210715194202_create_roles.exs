defmodule GoMovie.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles, primary_key: false) do
      add :role_id, :serial, primary_key: true
      add :name, :string
      add :description, :string
      add :status, :integer

      timestamps()
    end

  end
end

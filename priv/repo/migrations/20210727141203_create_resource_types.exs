defmodule GoMovie.Repo.Migrations.CreateResourceTypes do
  use Ecto.Migration

  def change do
    create table(:resource_types, primary_key: false) do
      add :resource_type_id, :serial, primary_key: true
      add :name, :string
      add :description, :string
      add :status, :integer

      timestamps()
    end

  end
end

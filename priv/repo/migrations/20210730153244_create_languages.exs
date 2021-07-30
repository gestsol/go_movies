defmodule GoMovie.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages, primary_key: false) do
      add :language_id, :serial, primary_key: true
      add :name, :string
      add :description, :string
      add :status, :integer

      timestamps()
    end

  end
end

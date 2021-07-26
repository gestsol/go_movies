defmodule GoMovie.Repo.Migrations.CreateResources do
  use Ecto.Migration

  def change do
    create table(:resources, primary_key: false) do
      add :resource_id, :serial, primary_key: true
      add :name, :string
      add :description, :string
      add :duration, :integer
      add :year, :integer
      add :url, :string
      add :trailer_url, :string
      add :poster_url, :string
      add :status, :integer
      add :score_average, :decimal
      add :season, :integer
      add :chapter, :integer

      timestamps()
      add :parent_resource_id, references(:resources, on_delete: :delete_all, column: :resource_id)
    end

  end
end

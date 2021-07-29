defmodule GoMovie.Repo.Migrations.CreateResourceGenders do
  use Ecto.Migration

  def change do
    create table(:resource_genders, primary_key: false) do
      add :status, :integer

      timestamps()
      add :resource_id, references(:resources, on_delete: :delete_all, column: :resource_id), primary_key: true
      add :gender_id, references(:genders, on_delete: :delete_all, column: :gender_id), primary_key: true
    end

  end
end

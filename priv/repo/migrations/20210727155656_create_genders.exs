defmodule GoMovie.Repo.Migrations.CreateGenders do
  use Ecto.Migration

  def change do
    create table(:genders, primary_key: false) do
      add :gender_id, :serial, primary_key: true
      add :name, :string
      add :description, :string
      add :status, :integer

      timestamps()
    end

  end
end

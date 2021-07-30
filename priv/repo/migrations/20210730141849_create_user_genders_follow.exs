defmodule GoMovie.Repo.Migrations.CreateUserGendersFollow do
  use Ecto.Migration

  def change do
    create table(:user_genders_follow, primary_key: false) do
      add :status, :integer

      timestamps()
      add :user_id, references(:users, on_delete: :delete_all, column: :user_id), primary_key: true
      add :gender_id, references(:genders, on_delete: :delete_all, column: :gender_id), primary_key: true

    end

  end
end

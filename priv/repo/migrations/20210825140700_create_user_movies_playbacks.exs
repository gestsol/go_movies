defmodule GoMovie.Repo.Migrations.CreateUserMoviesPlaybacks do
  use Ecto.Migration

  def change do
    create table(:user_movies_playbacks) do
      add :seekable, :decimal
      add :movie_id, :string
      add :user_id, references(:users, on_delete: :nothing, column: :user_id)

      timestamps()
    end

    create index(:user_movies_playbacks, [:user_id])
  end
end

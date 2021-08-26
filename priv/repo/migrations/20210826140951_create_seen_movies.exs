defmodule GoMovie.Repo.Migrations.CreateSeenMovies do
  use Ecto.Migration

  def change do
    create table(:seen_movies) do
      add :movie_id, :string
      add :user_id, references(:users, on_delete: :nothing, column: :user_id)

      timestamps()
    end

    create index(:seen_movies, [:user_id])
  end
end

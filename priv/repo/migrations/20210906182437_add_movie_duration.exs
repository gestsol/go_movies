defmodule GoMovie.Repo.Migrations.AddMovieDuration do
  use Ecto.Migration

  def change do
    alter table(:user_movies_playbacks) do
      add :duration, :decimal
    end
  end
end

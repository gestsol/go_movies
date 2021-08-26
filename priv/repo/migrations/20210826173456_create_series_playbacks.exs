defmodule GoMovie.Repo.Migrations.CreateSeriesPlaybacks do
  use Ecto.Migration

  def change do
    create table(:series_playbacks) do
      add :serie_id, :string
      add :season_id, :string
      add :chapter_id, :string
      add :seekable, :decimal
      add :user_id, references(:users, on_delete: :nothing, column: :user_id)

      timestamps()
    end

    create index(:series_playbacks, [:user_id])
  end
end

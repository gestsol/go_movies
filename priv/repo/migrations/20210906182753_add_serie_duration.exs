defmodule GoMovie.Repo.Migrations.AddSerieDuration do
  use Ecto.Migration

  def change do
    alter table(:series_playbacks) do
      add :duration, :decimal
    end
  end
end

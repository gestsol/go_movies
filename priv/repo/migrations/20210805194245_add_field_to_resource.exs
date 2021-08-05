defmodule GoMovie.Repo.Migrations.AddFieldToResource do
  use Ecto.Migration

  def change do
    alter table(:resources) do
      add :landscape_poster_url, :string
    end
  end
end

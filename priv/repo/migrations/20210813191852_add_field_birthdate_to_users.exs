defmodule GoMovie.Repo.Migrations.AddFieldBirthdateToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :birthdate, :date
    end
  end
end

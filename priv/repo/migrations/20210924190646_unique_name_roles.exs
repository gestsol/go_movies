defmodule GoMovie.Repo.Migrations.UniqueNameRoles do
  use Ecto.Migration

  def change do
    create unique_index(:roles, [:name])
  end
end

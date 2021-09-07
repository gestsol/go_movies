defmodule GoMovie.Repo.Migrations.CreateMainSliders do
  use Ecto.Migration

  def change do
    create table(:main_sliders) do
      add :title, :string
      add :description, :string
      add :img_url, :string
      add :link_1, :string
      add :link_2, :string
      add :status, :boolean, default: false, null: false

      timestamps()
    end

  end
end

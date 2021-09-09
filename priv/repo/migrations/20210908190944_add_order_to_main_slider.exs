defmodule GoMovie.Repo.Migrations.AddOrderToMainSlider do
  use Ecto.Migration

  def change do
    alter table(:main_sliders) do
      add :order, :integer
    end

    create unique_index(:main_sliders, [:order])
  end
end

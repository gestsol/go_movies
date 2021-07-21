defmodule GoMovie.Repo.Migrations.CreatePlans do
  use Ecto.Migration

  def change do
    create table(:plans, primary_key: false) do
      add :plan_id, :serial, primary_key: true
      add :name, :string
      add :description, :string
      add :price, :decimal
      add :duration, :integer
      add :device_quantity, :integer
      add :status, :integer

      timestamps()
    end

  end
end

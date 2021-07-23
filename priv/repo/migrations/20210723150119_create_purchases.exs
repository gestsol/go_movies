defmodule GoMovie.Repo.Migrations.CreatePurchases do
  use Ecto.Migration

  def change do
    create table(:purchases, primary_key: false) do
      add :purchase_id, :serial, primary_key: true

      add :date, :date
      add :amount, :decimal
      add :description, :string
      add :status, :integer

      timestamps()
      add :plan_id, references(:plans, on_delete: :delete_all, column: :plan_id)
      add :user_id, references(:users, on_delete: :delete_all, column: :user_id)
    end

  end
end

defmodule GoMovie.Repo.Migrations.CreateCodes do
  use Ecto.Migration

  def change do
    create table(:codes, primary_key: false) do
      add :code_id, :serial, primary_key: true
      add :name, :string
      add :description, :string
      add :quantity, :integer
      add :amount, :decimal
      add :date_end, :date
      add :status, :integer

      timestamps()
      add :plan_id, references(:plans, on_delete: :delete_all, column: :plan_id)
    end

  end
end

defmodule GoMovie.Repo.Migrations.CreateUserPlans do
  use Ecto.Migration

  def change do
    create table(:user_plans, primary_key: false) do
      add :date_start, :date
      add :date_end, :date
      add :status, :integer

      timestamps()
      add :plan_id, references(:plans, on_delete: :delete_all, column: :plan_id), primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, column: :user_id), primary_key: true
    end

  end
end

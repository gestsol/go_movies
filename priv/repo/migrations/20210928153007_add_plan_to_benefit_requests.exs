defmodule GoMovie.Repo.Migrations.AddPlanToBenefitRequests do
  use Ecto.Migration

  def change do
    alter table(:benefit_requests) do
      add :plan_id, references(:plans, on_delete: :delete_all, column: :plan_id)
    end
  end
end

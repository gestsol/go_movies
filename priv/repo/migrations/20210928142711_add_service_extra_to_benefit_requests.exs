defmodule GoMovie.Repo.Migrations.AddServiceExtraToBenefitRequests do
  use Ecto.Migration

  def change do
    alter table(:benefit_requests) do
      add :service_extra_livegps, :boolean
    end
  end
end

defmodule GoMovie.Repo.Migrations.CreateBenefitRequests do
  use Ecto.Migration

  def change do
    create table(:benefit_requests) do
      add :first_name, :string
      add :last_name, :string
      add :rut, :string
      add :email, :string
      add :phone_number, :string

      timestamps()
    end

    create unique_index(:benefit_requests, [:rut, :email])
  end
end

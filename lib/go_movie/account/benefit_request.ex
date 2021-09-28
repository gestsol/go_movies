defmodule GoMovie.Account.BenefitRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "benefit_requests" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :rut, :string
    field :service_extra_livegps, :boolean

    timestamps()
    belongs_to :plan, GoMovie.Business.Plan, foreign_key: :plan_id, references: :plan_id
  end

  @doc false
  def changeset(benefit_request, attrs) do
    benefit_request
    |> cast(attrs, [:first_name, :last_name, :rut, :email, :phone_number, :service_extra_livegps, :plan_id])
    |> validate_required([:first_name, :last_name, :rut, :email, :phone_number])
    |> unique_constraint([:rut, :email])
  end
end

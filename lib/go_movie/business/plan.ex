defmodule GoMovie.Business.Plan do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :plan_id}
	@primary_key {:plan_id, :id, autogenerate: true}

  schema "plans" do
    field :description, :string
    field :device_quantity, :integer
    field :duration, :integer
    field :name, :string
    field :price, :decimal
    field :status, :integer, default: 1

    timestamps()
  end

  @doc false
  def changeset(plan, attrs) do
    plan
    |> cast(attrs, [:name, :description, :price, :duration, :device_quantity, :status, :plan_id])
    |> validate_required([:name, :price, :duration, :status])
  end
end

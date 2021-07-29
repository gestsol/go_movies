defmodule GoMovie.Business.Code do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :code_id}
	@primary_key {:code_id, :id, autogenerate: true}

  schema "codes" do
    field :amount, :decimal
    field :date_end, :date
    field :description, :string
    field :name, :string
    field :quantity, :integer
    field :status, :integer, default: 1

    timestamps()
    belongs_to :plan, GoMovie.Business.Plan, foreign_key: :plan_id, references: :plan_id
  end

  @doc false
  def changeset(code, attrs) do
    code
    |> cast(attrs, [:name, :description, :quantity, :amount, :date_end, :status, :code_id, :plan_id])
    |> foreign_key_constraint(:plan_id)
    |> validate_required([:name, :quantity, :amount, :date_end, :status, :plan_id])
  end
end

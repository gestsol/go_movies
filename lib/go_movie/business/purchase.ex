defmodule GoMovie.Business.Purchase do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :purchase_id}
	@primary_key {:purchase_id, :id, autogenerate: true}

  schema "purchases" do
    field :amount, :decimal
    field :date, :date
    field :description, :string
    field :status, :integer, default: 1

    timestamps()
    belongs_to :plan, GoMovie.Business.Plan, foreign_key: :plan_id, references: :plan_id
    belongs_to :user, GoMovie.Account.User, foreign_key: :user_id, references: :user_id
  end

  @doc false
  def changeset(purchase, attrs) do
    purchase
    |> cast(attrs, [:date, :amount, :description, :status, :plan_id, :user_id, :purchase_id])
    |> foreign_key_constraint(:plan_id)
    |> foreign_key_constraint(:user_id)
    |> validate_required([:amount, :description, :plan_id, :user_id ])
  end
end

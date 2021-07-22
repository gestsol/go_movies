defmodule GoMovie.Business.UserPlan do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  schema "user_plans" do
    field :date_end, :date
    field :date_start, :date
    field :status, :integer, default: 1

    timestamps()
    belongs_to :plan, GoMovie.Business.Plan, foreign_key: :plan_id, references: :plan_id, primary_key: true
    belongs_to :user, GoMovie.Account.User, foreign_key: :user_id, references: :user_id, primary_key: true
  end

  @doc false
  def changeset(user_plan, attrs) do
    user_plan
    |> cast(attrs, [:date_start, :date_end, :status, :plan_id, :user_id])
    |> validate_required([:date_start, :date_end, :status])
  end
end

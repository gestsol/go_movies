defmodule GoMovie.Account.Role do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :role_id}
	@primary_key {:role_id, :id, autogenerate: true}

  schema "roles" do
    field :description, :string
    field :name, :string
    field :status, :integer, default: 1

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :description, :status, :role_id])
    |> validate_required([:name])
    |> unique_constraint([:name])
  end
end

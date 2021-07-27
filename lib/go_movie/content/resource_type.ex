defmodule GoMovie.Content.ResourceType do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :resource_type_id}
	@primary_key {:resource_type_id, :id, autogenerate: true}

  schema "resource_types" do
    field :description, :string
    field :name, :string
    field :status, :integer, default: 1

    timestamps()
  end

  @doc false
  def changeset(resource_type, attrs) do
    resource_type
    |> cast(attrs, [:name, :description, :status, :resource_type_id])
    |> validate_required([:name, :description, :status])
  end
end

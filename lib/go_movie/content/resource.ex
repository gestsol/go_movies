defmodule GoMovie.Content.Resource do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :resource_id}
	@primary_key {:resource_id, :id, autogenerate: true}

  schema "resources" do
    field :score_average, :decimal, default: 0.0
    field :chapter, :integer
    field :description, :string
    field :duration, :integer
    field :name, :string
    field :poster_url, :string
    field :season, :integer
    field :status, :integer, default: 1
    field :trailer_url, :string
    field :url, :string
    field :year, :integer

    timestamps()
    belongs_to :resources, __MODULE__, foreign_key: :parent_resource_id, references: :resource_id
    belongs_to :resource_types, GoMovie.Content.ResourceType, foreign_key: :resource_type_id, references: :resource_type_id
  end

  @doc false
  def changeset(resource, attrs) do
    resource
    |> cast(attrs, [:name, :description, :duration, :year, :url, :trailer_url, :poster_url, :status, :score_average, :season, :chapter, :resource_id, :parent_resource_id, :resource_type_id])
    |> validate_required([:name, :url])
  end
end

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
    field :landscape_poster_url, :string

    timestamps()
    belongs_to :resources, __MODULE__, foreign_key: :parent_resource_id, references: :resource_id
    belongs_to :resource_type, GoMovie.Content.ResourceType, foreign_key: :resource_type_id, references: :resource_type_id
    has_many :resource_genders, GoMovie.Content.ResourceGender, foreign_key: :resource_id, references: :resource_id
  end

  @doc false
  def changeset(resource, attrs) do
    resource
    |> cast(attrs, [:name, :description, :duration, :year, :url, :trailer_url, :poster_url, :status, :score_average, :season, :chapter, :resource_id, :parent_resource_id, :resource_type_id, :landscape_poster_url])
    |> foreign_key_constraint(:resource_type_id)
    |> foreign_key_constraint(:parent_resource_id)
    |> validate_required([:name])
  end
end

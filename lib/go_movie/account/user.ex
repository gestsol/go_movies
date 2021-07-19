defmodule GoMovie.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :user_id}
	@primary_key {:user_id, :id, autogenerate: true}

  schema "users" do
    field :address, :string
    field :city, :string
    field :country, :string
    field :email, :string
    field :image_url, :string
    field :lastname, :string
    field :name, :string
    field :password_hash, :string
    field :phone_number, :string
    field :postal_code, :string
    field :profile_description, :string
    field :sesion_counter, :integer
    field :status, :integer, default: 1

    timestamps()
    belongs_to :role, GoMovie.Account.Role, foreign_key: :role_id, references: :role_id
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :lastname, :email, :password_hash, :image_url, :status, :phone_number, :profile_description, :country, :city, :address, :postal_code, :sesion_counter, :user_id])
    |> validate_required([:name, :lastname, :email])
  end
end

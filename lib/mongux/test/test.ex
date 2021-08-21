defmodule Mongux.User do
  use Mongux.Schema

  import Mongux.Changeset

  mongo_schema "users" do
    field :name, :string
    field :lastname, :string
    field :country, [Mongux.Country]
  end

  def changeset(prueba, attrs) do
    prueba
    |> cast(attrs)
    |> validate_required([:name, :lastname, :country])
  end

end

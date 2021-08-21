defmodule Mongux.Test do
  use Mongux.Schema

  mongo_schema "prueba" do
    field :name, :string
    field :lastname, :string
  end

end

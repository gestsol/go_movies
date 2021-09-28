defmodule GoMovie.Account.UserSession do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_sessions" do
    field :browser, :string
    field :device, :string
    field :token, :string

    timestamps()
    belongs_to :user, GoMovie.Account.User, foreign_key: :user_id, references: :user_id
  end

  @doc false
  def changeset(user_session, attrs) do
    user_session
    |> cast(attrs, [:token, :browser, :device, :user_id])
    |> validate_required([:token, :user_id])
  end
end

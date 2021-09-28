defmodule GoMovie.Repo.Migrations.CreateUserSessions do
  use Ecto.Migration

  def change do
    create table(:user_sessions) do
      add :token, :string
      add :browser, :string
      add :device, :string
      add :user_id, references(:users, on_delete: :delete_all, column: :user_id)

      timestamps()
    end

    create index(:user_sessions, [:user_id])
  end
end

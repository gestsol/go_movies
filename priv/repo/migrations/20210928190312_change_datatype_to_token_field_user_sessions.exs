defmodule GoMovie.Repo.Migrations.ChangeDatatypeToTokenFieldUserSessions do
  use Ecto.Migration

  def change do
    alter table(:user_sessions) do
      modify :token, :text
    end
  end
end

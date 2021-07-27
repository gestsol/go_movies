defmodule GoMovie.Repo.Migrations.AddResourceTypeForeingKeyToResourceModel do
  use Ecto.Migration

  def change do
    alter table(:resources) do
      add :resource_type_id, references(:resource_types, on_delete: :delete_all, column: :resource_type_id)
    end
  end
end

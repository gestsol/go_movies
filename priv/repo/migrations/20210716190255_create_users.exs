defmodule GoMovie.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users,  primary_key: false) do
      add :user_id, :serial, primary_key: true
      add :name, :string
      add :lastname, :string
      add :email, :string
      add :password_hash, :string
      add :image_url, :string
      add :status, :integer
      add :phone_number, :string
      add :profile_description, :string
      add :country, :string
      add :city, :string
      add :address, :string
      add :postal_code, :string
      add :sesion_counter, :integer

      timestamps()
      add :role_id, references(:roles, on_delete: :delete_all, column: :role_id)
    end

  end
end

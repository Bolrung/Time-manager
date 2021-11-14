defmodule Timemanager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :role, :string, null: false
      add :password_hash, :string, null: false

      timestamps()
    end

    create(unique_index(:users, :username, name: "unique_username"))
    create(unique_index(:users, :email, name: "unique_email"))

    execute("INSERT INTO users (username, email, role, password_hash, inserted_at, updated_at) VALUES ('admin', 'admin@email.test', 'general', '$2b$12$VGVYychOl0eisgV1SRBl4eZVhYlzdR0yMXIcD3niBB9U8FGeKx.Z2', '2021-01-01 08:00:00-00', '2021-01-01 08:00:00-00')")
  end
end

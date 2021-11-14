defmodule Timemanager.Repo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :user, references(:users, on_delete: :delete_all), null: false
      add :token, :text, null: false
      add :created_at, :date, null: false
    end

    create index(:tokens, [:user])
  end
end

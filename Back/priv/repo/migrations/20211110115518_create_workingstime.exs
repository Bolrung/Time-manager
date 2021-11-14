defmodule Timemanager.Repo.Migrations.CreateWorkingstime do
  use Ecto.Migration

  def change do
    create table(:workingstime) do
      add :start, :naive_datetime, null: false
      add :end, :naive_datetime, null: false
      add :user, references(:users, on_delete: :delete_all), null: false
    end

    create index(:workingstime, [:user])
  end
end

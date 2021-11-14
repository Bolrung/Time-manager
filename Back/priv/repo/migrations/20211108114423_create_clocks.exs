defmodule Timemanager.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :start, :naive_datetime, null: false
      add :end, :naive_datetime
      add :user, references(:users, on_delete: :delete_all)
      add :fill, :boolean, null: false
    end

    create index(:clocks, [:user])
  end
end

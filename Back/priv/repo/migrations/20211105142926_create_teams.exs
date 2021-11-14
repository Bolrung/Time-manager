defmodule Timemanager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string, null: false
      add :leader, references(:users, on_delete: :nothing), null: false
    end

    create table(:teams_link) do
      add :user, references(:users, on_delete: :delete_all), null: false
      add :team, references(:teams, on_delete: :delete_all), null: false
    end

    create index(:teams, [:leader])
    create index(:teams_link, [:user])
    create index(:teams_link, [:team])
    create(unique_index(:teams, :name, name: "unique_teams_name"))
    create(unique_index(:teams_link, [:user, :team], name: "unique_link"))
  end
end

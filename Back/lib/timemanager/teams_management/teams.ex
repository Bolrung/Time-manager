defmodule Timemanager.TeamsManagement.Teams do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    field :leader, :id
  end

  @doc false
  def changeset(teams, attrs) do
    teams
    |> cast(attrs, [:name, :leader])
    |> unique_constraint([:name], name: "unique_teams_name")
    |> validate_required([:name, :leader])
  end
end

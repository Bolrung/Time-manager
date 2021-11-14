defmodule Timemanager.TeamsManagement.Teams_link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams_link" do
    field :user, :id
    field :team, :id
  end

  @doc false
  def changeset(teams_link, attrs) do
    teams_link
    |> cast(attrs, [:user, :team])
    |> unique_constraint([:user, :team], name: "unique_link")
    |> validate_required([:user, :team])
  end
end

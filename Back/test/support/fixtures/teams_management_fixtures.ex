defmodule Timemanager.TeamsManagementFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.TeamsManagement` context.
  """

  @doc """
  Generate a teams.
  """
  def teams_fixture(attrs \\ %{}) do
    {:ok, teams} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Timemanager.TeamsManagement.create_teams()

    teams
  end

  @doc """
  Generate a teams_link.
  """
  def teams_link_fixture(attrs \\ %{}) do
    {:ok, teams_link} =
      attrs
      |> Enum.into(%{

      })
      |> Timemanager.TeamsManagement.create_teams_link()

    teams_link
  end
end

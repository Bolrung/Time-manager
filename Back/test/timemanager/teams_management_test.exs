defmodule Timemanager.TeamsManagementTest do
  use Timemanager.DataCase

  alias Timemanager.TeamsManagement

  describe "teams" do
    alias Timemanager.TeamsManagement.Teams

    import Timemanager.TeamsManagementFixtures

    @invalid_attrs %{name: nil}

    test "list_teams/0 returns all teams" do
      teams = teams_fixture()
      assert TeamsManagement.list_teams() == [teams]
    end

    test "get_teams!/1 returns the teams with given id" do
      teams = teams_fixture()
      assert TeamsManagement.get_teams!(teams.id) == teams
    end

    test "create_teams/1 with valid data creates a teams" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Teams{} = teams} = TeamsManagement.create_teams(valid_attrs)
      assert teams.name == "some name"
    end

    test "create_teams/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TeamsManagement.create_teams(@invalid_attrs)
    end

    test "update_teams/2 with valid data updates the teams" do
      teams = teams_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Teams{} = teams} = TeamsManagement.update_teams(teams, update_attrs)
      assert teams.name == "some updated name"
    end

    test "update_teams/2 with invalid data returns error changeset" do
      teams = teams_fixture()
      assert {:error, %Ecto.Changeset{}} = TeamsManagement.update_teams(teams, @invalid_attrs)
      assert teams == TeamsManagement.get_teams!(teams.id)
    end

    test "delete_teams/1 deletes the teams" do
      teams = teams_fixture()
      assert {:ok, %Teams{}} = TeamsManagement.delete_teams(teams)
      assert_raise Ecto.NoResultsError, fn -> TeamsManagement.get_teams!(teams.id) end
    end

    test "change_teams/1 returns a teams changeset" do
      teams = teams_fixture()
      assert %Ecto.Changeset{} = TeamsManagement.change_teams(teams)
    end
  end

  describe "teams_link" do
    alias Timemanager.TeamsManagement.Teams_link

    import Timemanager.TeamsManagementFixtures

    @invalid_attrs %{}

    test "list_teams_link/0 returns all teams_link" do
      teams_link = teams_link_fixture()
      assert TeamsManagement.list_teams_link() == [teams_link]
    end

    test "get_teams_link!/1 returns the teams_link with given id" do
      teams_link = teams_link_fixture()
      assert TeamsManagement.get_teams_link!(teams_link.id) == teams_link
    end

    test "create_teams_link/1 with valid data creates a teams_link" do
      valid_attrs = %{}

      assert {:ok, %Teams_link{} = teams_link} = TeamsManagement.create_teams_link(valid_attrs)
    end

    test "create_teams_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TeamsManagement.create_teams_link(@invalid_attrs)
    end

    test "update_teams_link/2 with valid data updates the teams_link" do
      teams_link = teams_link_fixture()
      update_attrs = %{}

      assert {:ok, %Teams_link{} = teams_link} = TeamsManagement.update_teams_link(teams_link, update_attrs)
    end

    test "update_teams_link/2 with invalid data returns error changeset" do
      teams_link = teams_link_fixture()
      assert {:error, %Ecto.Changeset{}} = TeamsManagement.update_teams_link(teams_link, @invalid_attrs)
      assert teams_link == TeamsManagement.get_teams_link!(teams_link.id)
    end

    test "delete_teams_link/1 deletes the teams_link" do
      teams_link = teams_link_fixture()
      assert {:ok, %Teams_link{}} = TeamsManagement.delete_teams_link(teams_link)
      assert_raise Ecto.NoResultsError, fn -> TeamsManagement.get_teams_link!(teams_link.id) end
    end

    test "change_teams_link/1 returns a teams_link changeset" do
      teams_link = teams_link_fixture()
      assert %Ecto.Changeset{} = TeamsManagement.change_teams_link(teams_link)
    end
  end
end

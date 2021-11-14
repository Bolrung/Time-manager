defmodule TimemanagerWeb.TeamsController do
  use TimemanagerWeb, :controller

  alias Timemanager.Account
  alias Timemanager.TeamsManagement
  alias Timemanager.TeamsManagement.Teams
  alias Timemanager.TeamsManagement.Teams_link

  action_fallback TimemanagerWeb.FallbackController

  def create(conn, %{"team" => team_params}) do
    user = Account.get_users!(team_params["leader"])
    if (user.role == :employee) do
      conn
      |> put_status(:bad_request)
      |> json(%{error: "leader should not be an employee"})
    else
      with {:ok, %Teams{} = team} <- TeamsManagement.create_teams(team_params) do
        conn
        |> put_status(:created)
        |> render("show.json", teams: team)
      end
    end
  end

  def delete(conn, %{"teamID" => id}) do
    current = conn.assigns.current_user

    with team <- TeamsManagement.get_teams!(id) do
      if (team.leader == current.id || current.role == :general) do
        with {:ok, %Teams{}} <- TeamsManagement.delete_teams(team) do
          send_resp(conn, :no_content, "")
        end
      else
        conn
        |> put_status(:forbidden)
        |> json(%{error: "unauthorize to delete this team"})
      end
    end
  end

  def addtoteam(conn, %{"teamID" => id, "userID" => userid}) do
    team = TeamsManagement.get_teams!(id)
    Account.get_users!(userid)
    current = conn.assigns.current_user

    if (team.leader == current.id || current.role == :general) do
      with {:ok, %Teams_link{}} <- TeamsManagement.create_teams_link(%{user: userid, team: id}) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
      |> put_status(:forbidden)
      |> json(%{error: "unauthorize to add a user to this team"})
    end
  end

  def removetoteam(conn, %{"teamID" => id, "userID" => userid}) do
    current = conn.assigns.current_user
    team = TeamsManagement.get_teams!(id)

    if (team.leader == current.id || current.role == :general) do
      with nil <- TeamsManagement.get_teams_link!(id, userid) do
        conn
        |> put_status(404)
        |> json(%{error: "User not found in this team"})
      else
        teamslink ->
          with {:ok, %Teams_link{}} <- TeamsManagement.delete_teams_link(teamslink) do
            send_resp(conn, :no_content, "")
          end
      end
    else
      conn
      |> put_status(:forbidden)
      |> json(%{error: "unauthorize to remove this user from this team"})
    end
  end

  def getteam(conn, %{"teamID" => id}) do
    current = conn.assigns.current_user
    team = TeamsManagement.get_teams!(id)

    if (team.leader == current.id || current.role == :general) do
      users = TeamsManagement.get_teams_members!(id)
      leader = TeamsManagement.get_leader!(team.leader)
      conn
      |> put_status(:ok)
      |> json(%{name: team.name, leader: leader, members: users})
    end
  end
end

defmodule Timemanager.TeamsManagement do
  @moduledoc """
    Function list:
      create_teams
      create_teams_link
      delete_teams
      delete_teams_link
      get_teams!
      get_teams_link!
  """

  import Ecto.Query, warn: false
  alias Timemanager.Repo

  alias Timemanager.Account.Users
  alias Timemanager.TeamsManagement.Teams
  alias Timemanager.TeamsManagement.Teams_link

  ## LIMITE

  @doc """
    CREATE_TEAMS
    Creates a teams.

    ## Examples

    iex> create_teams(%{field: value})
      {:ok, %Teams{}}

    iex> create_teams(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_teams(attrs \\ %{}) do
    %Teams{}
    |> Teams.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    CREATE_TEAMS_LINK
    Creates a teams_link.

    ## Examples

    iex> create_teams_link(%{field: value})
      {:ok, %Teams_link{}}

    iex> create_teams_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_teams_link(attrs \\ %{}) do
    %Teams_link{}
    |> Teams_link.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    DELETE_TEAMS
    Deletes a teams.

    ## Examples

    iex> delete_teams(teams)
      {:ok, %Teams{}}

    iex> delete_teams(teams)
      {:error, %Ecto.Changeset{}}
  """
  def delete_teams(%Teams{} = teams), do: Repo.delete(teams)

  @doc """
    DELETE_TEAMS_LINK
    Deletes a teams_link.

    ## Examples

    iex> delete_teams_link(teams_link)
      {:ok, %Teams_link{}}

    iex> delete_teams_link(teams_link)
      {:error, %Ecto.Changeset{}}
  """
  def delete_teams_link(%Teams_link{} = teams_link), do: Repo.delete(teams_link)

  @doc """
    GET_TEAMS
    Gets a single teams.

    Raises `Ecto.NoResultsError` if the Teams does not exist.

    ## Examples

    iex> get_teams!(123)
      %Teams{}

    iex> get_teams!(456)
      ** (Ecto.NoResultsError)
  """
  def get_teams!(id), do: Repo.get!(Teams, id)

  @doc false
  def get_leader!(id) do
    query = from u in Users, where: u.id == ^id, select: %{id: u.id, username: u.username, email: u.email, role: u.role}
    Repo.one(query)
  end

  @doc """
    GET_TEAMS_LINK
    Gets a single teams_link.

    Raises `Ecto.NoResultsError` if the Teams link does not exist.

    ## Examples

    iex> get_teams_link!(123)
      %Teams_link{}

    iex> get_teams_link!(456)
      ** (Ecto.NoResultsError)
  """
  def get_teams_link!(teamid, userid), do: Repo.get_by!(Teams_link, user: userid, team: teamid)

  @doc false
  def get_teams_members!(id) do
    query = from u in Users, join: tl in Teams_link, where: tl.team == ^id, where: tl.user == u.id, select: %{id: u.id, username: u.username, email: u.email, role: u.role}
    Repo.all(query)
  end
end

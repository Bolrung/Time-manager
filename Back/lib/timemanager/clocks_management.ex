defmodule Timemanager.ClocksManagement do
  @moduledoc """
    Functions list:
      
  """

  import Ecto.Query, warn: false
  alias Timemanager.Repo

  alias Timemanager.ClocksManagement.Clocks

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clocks{}, ...]

  """
  def list_clocks do
    Repo.all(Clocks)
  end

  @doc """
  Gets a single clocks.

  Raises `Ecto.NoResultsError` if the Clocks does not exist.

  ## Examples

      iex> get_clocks!(123)
      %Clocks{}

      iex> get_clocks!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clocks!(id), do: Repo.get!(Clocks, id)

  @doc """
  Creates a clocks.

  ## Examples

      iex> create_clocks(%{field: value})
      {:ok, %Clocks{}}

      iex> create_clocks(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clocks(attrs \\ %{}) do
    %Clocks{}
    |> Clocks.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clocks.

  ## Examples

      iex> update_clocks(clocks, %{field: new_value})
      {:ok, %Clocks{}}

      iex> update_clocks(clocks, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clocks(%Clocks{} = clocks, attrs) do
    clocks
    |> Clocks.completset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clocks.

  ## Examples

      iex> delete_clocks(clocks)
      {:ok, %Clocks{}}

      iex> delete_clocks(clocks)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clocks(%Clocks{} = clocks) do
    Repo.delete(clocks)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clocks changes.

  ## Examples

      iex> change_clocks(clocks)
      %Ecto.Changeset{data: %Clocks{}}

  """
  def change_clocks(%Clocks{} = clocks, attrs \\ %{}) do
    Clocks.changeset(clocks, attrs)
  end

  alias Timemanager.ClocksManagement.WorkingsTime

  @doc """
  Returns the list of workingstime.

  ## Examples

      iex> list_workingstime()
      [%WorkingsTime{}, ...]

  """
  def list_workingstime do
    Repo.all(WorkingsTime)
  end

  @doc """
  Gets a single workings_time.

  Raises `Ecto.NoResultsError` if the Workings time does not exist.

  ## Examples

      iex> get_workings_time!(123)
      %WorkingsTime{}

      iex> get_workings_time!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workings_time!(id), do: Repo.get!(WorkingsTime, id)

  @doc """
  Creates a workings_time.

  ## Examples

      iex> create_workings_time(%{field: value})
      {:ok, %WorkingsTime{}}

      iex> create_workings_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workings_time(attrs \\ %{}) do
    %WorkingsTime{}
    |> WorkingsTime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workings_time.

  ## Examples

      iex> update_workings_time(workings_time, %{field: new_value})
      {:ok, %WorkingsTime{}}

      iex> update_workings_time(workings_time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workings_time(%WorkingsTime{} = workings_time, attrs) do
    workings_time
    |> WorkingsTime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a workings_time.

  ## Examples

      iex> delete_workings_time(workings_time)
      {:ok, %WorkingsTime{}}

      iex> delete_workings_time(workings_time)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workings_time(%WorkingsTime{} = workings_time) do
    Repo.delete(workings_time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workings_time changes.

  ## Examples

      iex> change_workings_time(workings_time)
      %Ecto.Changeset{data: %WorkingsTime{}}

  """
  def change_workings_time(%WorkingsTime{} = workings_time, attrs \\ %{}) do
    WorkingsTime.changeset(workings_time, attrs)
  end

  def get_arrived!(id) do
    Repo.get_by(Clocks, user: id, fill: false)
  end
end

defmodule Timemanager.ClocksManagementFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.ClocksManagement` context.
  """

  @doc """
  Generate a clocks.
  """
  def clocks_fixture(attrs \\ %{}) do
    {:ok, clocks} =
      attrs
      |> Enum.into(%{
        end: ~N[2021-11-07 11:44:00],
        start: ~N[2021-11-07 11:44:00],
        working_time: ~N[2021-11-07 11:44:00]
      })
      |> Timemanager.ClocksManagement.create_clocks()

    clocks
  end

  @doc """
  Generate a workings_time.
  """
  def workings_time_fixture(attrs \\ %{}) do
    {:ok, workings_time} =
      attrs
      |> Enum.into(%{
        end: ~N[2021-11-09 11:55:00],
        start: ~N[2021-11-09 11:55:00]
      })
      |> Timemanager.ClocksManagement.create_workings_time()

    workings_time
  end
end

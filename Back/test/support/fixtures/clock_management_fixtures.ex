defmodule Timemanager.ClockManagementFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.ClockManagement` context.
  """

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
      |> Timemanager.ClockManagement.create_workings_time()

    workings_time
  end
end

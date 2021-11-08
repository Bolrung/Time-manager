defmodule Theme01.DirectoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Theme01.Directory` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> Theme01.Directory.create_user()

    user
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2021-10-25 11:40:00]
      })
      |> Theme01.Directory.create_clock()

    clock
  end

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~N[2021-10-25 11:41:00],
        start: ~N[2021-10-25 11:41:00]
      })
      |> Theme01.Directory.create_workingtime()

    workingtime
  end
end

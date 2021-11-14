defmodule Timemanager.ClockManagementTest do
  use Timemanager.DataCase

  alias Timemanager.ClockManagement

  describe "workingstime" do
    alias Timemanager.ClockManagement.WorkingsTime

    import Timemanager.ClockManagementFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingstime/0 returns all workingstime" do
      workings_time = workings_time_fixture()
      assert ClockManagement.list_workingstime() == [workings_time]
    end

    test "get_workings_time!/1 returns the workings_time with given id" do
      workings_time = workings_time_fixture()
      assert ClockManagement.get_workings_time!(workings_time.id) == workings_time
    end

    test "create_workings_time/1 with valid data creates a workings_time" do
      valid_attrs = %{end: ~N[2021-11-09 11:55:00], start: ~N[2021-11-09 11:55:00]}

      assert {:ok, %WorkingsTime{} = workings_time} = ClockManagement.create_workings_time(valid_attrs)
      assert workings_time.end == ~N[2021-11-09 11:55:00]
      assert workings_time.start == ~N[2021-11-09 11:55:00]
    end

    test "create_workings_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ClockManagement.create_workings_time(@invalid_attrs)
    end

    test "update_workings_time/2 with valid data updates the workings_time" do
      workings_time = workings_time_fixture()
      update_attrs = %{end: ~N[2021-11-10 11:55:00], start: ~N[2021-11-10 11:55:00]}

      assert {:ok, %WorkingsTime{} = workings_time} = ClockManagement.update_workings_time(workings_time, update_attrs)
      assert workings_time.end == ~N[2021-11-10 11:55:00]
      assert workings_time.start == ~N[2021-11-10 11:55:00]
    end

    test "update_workings_time/2 with invalid data returns error changeset" do
      workings_time = workings_time_fixture()
      assert {:error, %Ecto.Changeset{}} = ClockManagement.update_workings_time(workings_time, @invalid_attrs)
      assert workings_time == ClockManagement.get_workings_time!(workings_time.id)
    end

    test "delete_workings_time/1 deletes the workings_time" do
      workings_time = workings_time_fixture()
      assert {:ok, %WorkingsTime{}} = ClockManagement.delete_workings_time(workings_time)
      assert_raise Ecto.NoResultsError, fn -> ClockManagement.get_workings_time!(workings_time.id) end
    end

    test "change_workings_time/1 returns a workings_time changeset" do
      workings_time = workings_time_fixture()
      assert %Ecto.Changeset{} = ClockManagement.change_workings_time(workings_time)
    end
  end
end

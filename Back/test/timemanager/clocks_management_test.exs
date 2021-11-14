defmodule Timemanager.ClocksManagementTest do
  use Timemanager.DataCase

  alias Timemanager.ClocksManagement

  describe "clocks" do
    alias Timemanager.ClocksManagement.Clocks

    import Timemanager.ClocksManagementFixtures

    @invalid_attrs %{end: nil, start: nil, working_time: nil}

    test "list_clocks/0 returns all clocks" do
      clocks = clocks_fixture()
      assert ClocksManagement.list_clocks() == [clocks]
    end

    test "get_clocks!/1 returns the clocks with given id" do
      clocks = clocks_fixture()
      assert ClocksManagement.get_clocks!(clocks.id) == clocks
    end

    test "create_clocks/1 with valid data creates a clocks" do
      valid_attrs = %{end: ~N[2021-11-07 11:44:00], start: ~N[2021-11-07 11:44:00], working_time: ~N[2021-11-07 11:44:00]}

      assert {:ok, %Clocks{} = clocks} = ClocksManagement.create_clocks(valid_attrs)
      assert clocks.end == ~N[2021-11-07 11:44:00]
      assert clocks.start == ~N[2021-11-07 11:44:00]
      assert clocks.working_time == ~N[2021-11-07 11:44:00]
    end

    test "create_clocks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ClocksManagement.create_clocks(@invalid_attrs)
    end

    test "update_clocks/2 with valid data updates the clocks" do
      clocks = clocks_fixture()
      update_attrs = %{end: ~N[2021-11-08 11:44:00], start: ~N[2021-11-08 11:44:00], working_time: ~N[2021-11-08 11:44:00]}

      assert {:ok, %Clocks{} = clocks} = ClocksManagement.update_clocks(clocks, update_attrs)
      assert clocks.end == ~N[2021-11-08 11:44:00]
      assert clocks.start == ~N[2021-11-08 11:44:00]
      assert clocks.working_time == ~N[2021-11-08 11:44:00]
    end

    test "update_clocks/2 with invalid data returns error changeset" do
      clocks = clocks_fixture()
      assert {:error, %Ecto.Changeset{}} = ClocksManagement.update_clocks(clocks, @invalid_attrs)
      assert clocks == ClocksManagement.get_clocks!(clocks.id)
    end

    test "delete_clocks/1 deletes the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{}} = ClocksManagement.delete_clocks(clocks)
      assert_raise Ecto.NoResultsError, fn -> ClocksManagement.get_clocks!(clocks.id) end
    end

    test "change_clocks/1 returns a clocks changeset" do
      clocks = clocks_fixture()
      assert %Ecto.Changeset{} = ClocksManagement.change_clocks(clocks)
    end
  end

  describe "workingstime" do
    alias Timemanager.ClocksManagement.WorkingsTime

    import Timemanager.ClocksManagementFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingstime/0 returns all workingstime" do
      workings_time = workings_time_fixture()
      assert ClocksManagement.list_workingstime() == [workings_time]
    end

    test "get_workings_time!/1 returns the workings_time with given id" do
      workings_time = workings_time_fixture()
      assert ClocksManagement.get_workings_time!(workings_time.id) == workings_time
    end

    test "create_workings_time/1 with valid data creates a workings_time" do
      valid_attrs = %{end: ~N[2021-11-09 11:55:00], start: ~N[2021-11-09 11:55:00]}

      assert {:ok, %WorkingsTime{} = workings_time} = ClocksManagement.create_workings_time(valid_attrs)
      assert workings_time.end == ~N[2021-11-09 11:55:00]
      assert workings_time.start == ~N[2021-11-09 11:55:00]
    end

    test "create_workings_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ClocksManagement.create_workings_time(@invalid_attrs)
    end

    test "update_workings_time/2 with valid data updates the workings_time" do
      workings_time = workings_time_fixture()
      update_attrs = %{end: ~N[2021-11-10 11:55:00], start: ~N[2021-11-10 11:55:00]}

      assert {:ok, %WorkingsTime{} = workings_time} = ClocksManagement.update_workings_time(workings_time, update_attrs)
      assert workings_time.end == ~N[2021-11-10 11:55:00]
      assert workings_time.start == ~N[2021-11-10 11:55:00]
    end

    test "update_workings_time/2 with invalid data returns error changeset" do
      workings_time = workings_time_fixture()
      assert {:error, %Ecto.Changeset{}} = ClocksManagement.update_workings_time(workings_time, @invalid_attrs)
      assert workings_time == ClocksManagement.get_workings_time!(workings_time.id)
    end

    test "delete_workings_time/1 deletes the workings_time" do
      workings_time = workings_time_fixture()
      assert {:ok, %WorkingsTime{}} = ClocksManagement.delete_workings_time(workings_time)
      assert_raise Ecto.NoResultsError, fn -> ClocksManagement.get_workings_time!(workings_time.id) end
    end

    test "change_workings_time/1 returns a workings_time changeset" do
      workings_time = workings_time_fixture()
      assert %Ecto.Changeset{} = ClocksManagement.change_workings_time(workings_time)
    end
  end
end

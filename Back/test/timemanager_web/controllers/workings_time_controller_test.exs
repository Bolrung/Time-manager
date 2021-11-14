defmodule TimemanagerWeb.WorkingsTimeControllerTest do
  use TimemanagerWeb.ConnCase

  import Timemanager.ClocksManagementFixtures

  alias Timemanager.ClocksManagement.WorkingsTime

  @create_attrs %{
    end: ~N[2021-11-09 11:55:00],
    start: ~N[2021-11-09 11:55:00]
  }
  @update_attrs %{
    end: ~N[2021-11-10 11:55:00],
    start: ~N[2021-11-10 11:55:00]
  }
  @invalid_attrs %{end: nil, start: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all workingstime", %{conn: conn} do
      conn = get(conn, Routes.workings_time_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create workings_time" do
    test "renders workings_time when data is valid", %{conn: conn} do
      conn = post(conn, Routes.workings_time_path(conn, :create), workings_time: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.workings_time_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "end" => "2021-11-09T11:55:00",
               "start" => "2021-11-09T11:55:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.workings_time_path(conn, :create), workings_time: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update workings_time" do
    setup [:create_workings_time]

    test "renders workings_time when data is valid", %{conn: conn, workings_time: %WorkingsTime{id: id} = workings_time} do
      conn = put(conn, Routes.workings_time_path(conn, :update, workings_time), workings_time: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.workings_time_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "end" => "2021-11-10T11:55:00",
               "start" => "2021-11-10T11:55:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, workings_time: workings_time} do
      conn = put(conn, Routes.workings_time_path(conn, :update, workings_time), workings_time: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete workings_time" do
    setup [:create_workings_time]

    test "deletes chosen workings_time", %{conn: conn, workings_time: workings_time} do
      conn = delete(conn, Routes.workings_time_path(conn, :delete, workings_time))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.workings_time_path(conn, :show, workings_time))
      end
    end
  end

  defp create_workings_time(_) do
    workings_time = workings_time_fixture()
    %{workings_time: workings_time}
  end
end

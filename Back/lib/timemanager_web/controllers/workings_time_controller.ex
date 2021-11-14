defmodule TimemanagerWeb.WorkingsTimeController do
  use TimemanagerWeb, :controller

  alias Timemanager.Account
  alias Timemanager.ClocksManagement
  alias Timemanager.ClocksManagement.WorkingsTime

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    workingstime = ClocksManagement.list_workingstime()
    render(conn, "index.json", workingstime: workingstime)
  end

  def show(conn, %{"id" => id}) do
    workings_time = ClocksManagement.get_workings_time!(id)
    render(conn, "show.json", workings_time: workings_time)
  end

  def update(conn, %{"id" => id, "workings_time" => workings_time_params}) do
    workings_time = ClocksManagement.get_workings_time!(id)

    with {:ok, %WorkingsTime{} = workings_time} <- ClocksManagement.update_workings_time(workings_time, workings_time_params) do
      render(conn, "show.json", workings_time: workings_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    workings_time = ClocksManagement.get_workings_time!(id)

    with {:ok, %WorkingsTime{}} <- ClocksManagement.delete_workings_time(workings_time) do
      send_resp(conn, :no_content, "")
    end
  end

  def create(conn, %{"userID" => id, "workingtime" => workingtime_params}) do
    Account.get_users!(id)
    start = DateTime.from_unix!(workingtime_params["start"])
    end_ = DateTime.from_unix!(workingtime_params["end"])

    with {:ok, %WorkingsTime{}} <- ClocksManagement.create_workings_time(%{user: id, start: start, end: end_}) do
      conn
      |> put_status(:created)
      |> json(%{msg: "working time create"})
    end
  end
end

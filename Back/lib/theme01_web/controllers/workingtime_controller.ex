defmodule Theme01Web.WorkingtimeController do
  use Theme01Web, :controller

  alias Theme01.Directory
  alias Theme01.Directory.Workingtime

  action_fallback Theme01Web.FallbackController

  def index(conn, %{"userID" => userid, "start" => start, "end" => end_}) do
    IO.puts("test")
    workingtimes = Directory.list_workingtimes!(userid, start, end_)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"userID" => userid, "workingtime" => workingtime_params}) do
    Directory.get_user!(userid)
    #start = workingtime_params["start"]
    #end_ = workingtime_params["end"]
    start = DateTime.from_unix!(workingtime_params["start"])
    end_ = DateTime.from_unix!(workingtime_params["end"])
    with {:ok, %Workingtime{} = workingtime} <- Directory.create_workingtime(%{user: userid, start: start, end: end_}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, userid, workingtime.id))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => userid, "id" => id}) do
    Directory.get_user!(userid)
    workingtime = Directory.get_workingtime_with_userid!(id, userid)
    render(conn, "show.json", workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Directory.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Directory.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Directory.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Directory.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end

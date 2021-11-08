defmodule Theme01Web.ClockController do
  use Theme01Web, :controller

  alias Theme01.Directory
  alias Theme01.Directory.Clock

  action_fallback Theme01Web.FallbackController

  # def index(conn, _params) do
  #   clocks = Directory.list_clocks!()
  #   render(conn, "index.json", clocks: clocks)
  # end

  def create(conn, %{"userID" => userid, "clock" => clock_params}) do
    Directory.get_user!(userid)
    with {:ok, %Clock{} = clock} <- Directory.create_clock(%{user: userid, status: false, time: clock_params["time"]}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"userID" => id}) do
    clock = Directory.list_clocks!(id)
    render(conn, "index.json", clock: clock)
  end

  # def update(conn, %{"id" => id, "clock" => clock_params}) do
  #   clock = Directory.get_clock!(id)

  #   with {:ok, %Clock{} = clock} <- Directory.update_clock(clock, clock_params) do
  #     render(conn, "show.json", clock: clock)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   clock = Directory.get_clock!(id)

  #   with {:ok, %Clock{}} <- Directory.delete_clock(clock) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end

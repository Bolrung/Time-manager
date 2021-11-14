defmodule TimemanagerWeb.ClocksController do
  use TimemanagerWeb, :controller

  alias Timemanager.ClocksManagement
  alias Timemanager.ClocksManagement.Clocks

  action_fallback TimemanagerWeb.FallbackController

  # def index(conn, _params) do
  #   clocks = ClocksManagement.list_clocks()
  #   render(conn, "index.json", clocks: clocks)
  # end

  # def create(conn, %{"clocks" => clocks_params}) do
  #   with {:ok, %Clocks{} = clocks} <- ClocksManagement.create_clocks(clocks_params) do
  #     conn
  #     |> put_status(:created)
  #     |> render("show.json", clocks: clocks)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   clocks = ClocksManagement.get_clocks!(id)
  #   render(conn, "show.json", clocks: clocks)
  # end

  # def update(conn, %{"id" => id, "clocks" => clocks_params}) do
  #   clocks = ClocksManagement.get_clocks!(id)

  #   with {:ok, %Clocks{} = clocks} <- ClocksManagement.update_clocks(clocks, clocks_params) do
  #     render(conn, "show.json", clocks: clocks)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   clocks = ClocksManagement.get_clocks!(id)

  #   with {:ok, %Clocks{}} <- ClocksManagement.delete_clocks(clocks) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end

  def create(conn, _params) do
    current = conn.assigns.current_user
    time = DateTime.now!("Etc/UTC")

    with nil <- ClocksManagement.get_arrived!(current.id) do
      with {:ok, %Clocks{}} <- ClocksManagement.create_clocks(%{user: current.id, start: time, fill: false}) do
        send_resp(conn, :no_content, "")
      end
    else
      clock ->
        with {:ok, %Clocks{}} <- ClocksManagement.update_clocks(clock, %{end: time, fill: true}) do
          send_resp(conn, :no_content, "")
        end
    end
  end
end

defmodule TimemanagerWeb.Plugs.IsGeneral do
    import Plug.Conn
    require Logger

    alias Timemanager.Account.Users

    def init(opts) do
        opts
    end

    def call(conn, _opts) do
        if (conn.assigns.current_user.role != :general) do
            conn
            |> put_status(:forbidden)
            |> Phoenix.Controller.put_view(TimemanagerWeb.ErrorView)
            |> Phoenix.Controller.render(:"#{403}")
            |> halt()
        else
            conn
        end
    end
end
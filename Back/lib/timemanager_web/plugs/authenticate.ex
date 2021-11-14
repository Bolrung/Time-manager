defmodule TimemanagerWeb.Plugs.Authenticate do
  import Plug.Conn
  require Logger

  alias Timemanager.Account.Users
  alias Timemanager.Account.Tokens

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization") do
      with {:ok, %Users{} = user} <- Timemanager.Account.get_user_by_session_token(token) do
        with {:ok, _} <- Timemanager.Token.verify_and_validate(token) do
          conn
          |> assign(:current_user, user)
        else
          _ ->
            with {:ok, %Tokens{} = tokens} <- Timemanager.Account.get_token!(token) do
              with {:ok, _} <- Timemanager.Account.delete_token(tokens) do
                send_resp(conn, :no_content, "")
              end
            end
        end
      else
        {:error, _} ->
          conn
          |> put_status(404)
          |> Phoenix.Controller.put_view(TimemanagerWeb.ErrorView)
          |> Phoenix.Controller.render(:"#{404}")
          |> halt()
      end
    else
      _ ->
        conn
        |> put_status(401)
        |> Phoenix.Controller.put_view(TimemanagerWeb.ErrorView)
        |> Phoenix.Controller.render(:"401")
        |> halt()
    end
  end
end
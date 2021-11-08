defmodule Theme01Web.UserController do
  use Theme01Web, :controller

  alias Theme01.Directory
  alias Theme01.Directory.User

  action_fallback Theme01Web.FallbackController

  def index(conn, %{"email" => email, "username" => username}) do
    user = Directory.list_users!(email, username)
    render(conn, "show.json", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Directory.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"userID" => id}) do
    user = Directory.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"userID" => id, "user" => user_params}) do
    user = Directory.get_user!(id)

    with {:ok, %User{} = user} <- Directory.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"userID" => id}) do
    user = Directory.get_user!(id)

    with {:ok, %User{}} <- Directory.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end

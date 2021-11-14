defmodule TimemanagerWeb.UsersController do
  use TimemanagerWeb, :controller

  alias Timemanager.Account
  alias Timemanager.Account.Users
  alias Timemanager.Account.Tokens

  action_fallback TimemanagerWeb.FallbackController

  def delete(conn, _params) do
    with {:ok, %Users{}} <- Account.delete_users(conn.assigns.current_user) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete_user(conn, %{"userID" => id}) do
    user = Account.get_users!(id)
    with {:ok, %Users{}} <- Account.delete_users(user) do
      send_resp(conn, :no_content, "")
    end
  end
  
  def promote(conn, %{"userID" => id}) do
    user = Account.get_users!(id)
    if (user.role != :employee) do
      conn
      |> put_status(:bad_request)
      |> json(%{error: "target to promotion isn't an employee"})
    end
    with {:ok, %Users{}} <- Account.promote_user(user, %{role: "manager"}) do
      conn
      |> put_status(:ok)
      |> json(%{msg: "promotion was done"})
    end
  end

  def show(conn, _params), do: render(conn, "show.json", users: conn.assigns.current_user)
  
  def show_user(conn, %{"userID" => userid}) do
    user = Account.get_users!(userid)
    render(conn, "show.json", users: user)
  end

  def sign_in(conn, %{"login" => login_params}) do
    with nil <- Account.get_user_by_username!(login_params["username"]) do
      conn
        |> put_status(:bad_request)
        |> json(%{error: "Invalid username"})
    else
      user ->
        with {:ok, %Users{}} <- Bcrypt.check_pass(user, login_params["password"]),
              {:ok, token, _claims} <- Timemanager.Token.generate_and_sign() do
          with {:ok, %Tokens{} = tokens} <- Account.create_token(%{user: user.id, token: token, created_at: DateTime.now!("Etc/UTC"), status: "tempory"}) do
            render(conn, "show.json", tokens: tokens)
          end
        else
          {:error, _} ->
            conn
            |> put_status(:bad_request)
            |> json(%{error: "Invalid password"})
        end
    end
  end

  def sign_out(conn, _params) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization") do
      tokens = Account.get_token!(token)
      with {:ok, _} <- Account.delete_token(tokens) do
        send_resp(conn, :no_content, "")
      end
    end
  end
  
  def sign_up(conn, %{"register" => user_params}) do
    with {:ok, %Users{} = user} <- Account.create_user(%{username: user_params["username"], email: user_params["email"], password: user_params["password"], role: "employee"}),
         {:ok, token, _claims} <- Timemanager.Token.generate_and_sign() do
      with {:ok, %Tokens{} = tokens} <- Account.create_token(%{user: user.id, token: token, created_at: DateTime.now!("Etc/UTC"), status: "tempory"}) do
        render(conn, "show.json", tokens: tokens)
      end
    else
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> put_view(TimemanagerWeb.ErrorView)
        |> render("error.json", changeset: changeset)
    end
  end

  def update(conn, %{"user" => user_params}) do
    with {:ok, %Users{}} <- Account.update_users(conn.assigns.current_user, user_params) do
      conn
      |> put_status(:created)
      |> json(%{msg: "update was done"})
    end
  end

  def mofify_user(conn, %{"userID" => id, "user" => user_params}) do
    user = Account.get_users!(id)

    with {:ok, %Users{}} <- Account.update_users(user, user_params) do
      conn
      |> put_status(:created)
      |> json(%{msg: "update was done"})
    end
  end

  def index(conn, _params) do
    users = Account.get_all_users()
    render(conn, "index.json", users: users)
  end
end

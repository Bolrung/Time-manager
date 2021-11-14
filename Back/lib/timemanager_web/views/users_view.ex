defmodule TimemanagerWeb.UsersView do
  use TimemanagerWeb, :view
  alias TimemanagerWeb.UsersView
  alias TimemanagerWeb.TokensView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UsersView, "users.json")}
  end

  def render("show.json", %{users: users}) do
    %{data: render_one(users, UsersView, "users.json")}
  end

  def render("users.json", %{users: users}) do
    %{
      id: users.id,
      username: users.username,
      email: users.email,
      role: users.role,
    }
  end

  def render("show.json", %{tokens: tokens}) do
    %{data: render_one(tokens, TokensView, "tokens.json")}
  end
end

defmodule TimemanagerWeb.TokensView do
  use TimemanagerWeb, :view
  alias TimemanagerWeb.TokensView

  def render("index.json", %{tokens: tokens}) do
    %{data: render_many(tokens, TokensView, "tokens.json")}
  end

  def render("show.json", %{tokens: tokens}) do
    %{data: render_one(tokens, TokensView, "tokens.json")}
  end

  def render("tokens.json", %{tokens: tokens}) do
    %{
      token: tokens.token,
    }
  end
end

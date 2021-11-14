defmodule Timemanager.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.Account` context.
  """

  @doc """
  Generate a users.
  """
  def users_fixture(attrs \\ %{}) do
    {:ok, users} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password_hash: "some password_hash",
        role: "some role",
        username: "some username"
      })
      |> Timemanager.Account.create_users()

    users
  end

  @doc """
  Generate a tokens.
  """
  def tokens_fixture(attrs \\ %{}) do
    {:ok, tokens} =
      attrs
      |> Enum.into(%{
        created_at: ~D[2021-11-03],
        status: "some status",
        token: "some token"
      })
      |> Timemanager.Account.create_tokens()

    tokens
  end
end

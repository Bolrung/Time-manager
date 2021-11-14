defmodule Timemanager.AccountTest do
  use Timemanager.DataCase

  alias Timemanager.Account

  describe "users" do
    alias Timemanager.Account.Users

    import Timemanager.AccountFixtures

    @invalid_attrs %{email: nil, password_hash: nil, role: nil, username: nil}

    test "list_users/0 returns all users" do
      users = users_fixture()
      assert Account.list_users() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Account.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      valid_attrs = %{email: "some email", password_hash: "some password_hash", role: "some role", username: "some username"}

      assert {:ok, %Users{} = users} = Account.create_users(valid_attrs)
      assert users.email == "some email"
      assert users.password_hash == "some password_hash"
      assert users.role == "some role"
      assert users.username == "some username"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      update_attrs = %{email: "some updated email", password_hash: "some updated password_hash", role: "some updated role", username: "some updated username"}

      assert {:ok, %Users{} = users} = Account.update_users(users, update_attrs)
      assert users.email == "some updated email"
      assert users.password_hash == "some updated password_hash"
      assert users.role == "some updated role"
      assert users.username == "some updated username"
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_users(users, @invalid_attrs)
      assert users == Account.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Account.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Account.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Account.change_users(users)
    end
  end

  describe "tokens" do
    alias Timemanager.Account.Tokens

    import Timemanager.AccountFixtures

    @invalid_attrs %{created_at: nil, status: nil, token: nil}

    test "list_tokens/0 returns all tokens" do
      tokens = tokens_fixture()
      assert Account.list_tokens() == [tokens]
    end

    test "get_tokens!/1 returns the tokens with given id" do
      tokens = tokens_fixture()
      assert Account.get_tokens!(tokens.id) == tokens
    end

    test "create_tokens/1 with valid data creates a tokens" do
      valid_attrs = %{created_at: ~D[2021-11-03], status: "some status", token: "some token"}

      assert {:ok, %Tokens{} = tokens} = Account.create_tokens(valid_attrs)
      assert tokens.created_at == ~D[2021-11-03]
      assert tokens.status == "some status"
      assert tokens.token == "some token"
    end

    test "create_tokens/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_tokens(@invalid_attrs)
    end

    test "update_tokens/2 with valid data updates the tokens" do
      tokens = tokens_fixture()
      update_attrs = %{created_at: ~D[2021-11-04], status: "some updated status", token: "some updated token"}

      assert {:ok, %Tokens{} = tokens} = Account.update_tokens(tokens, update_attrs)
      assert tokens.created_at == ~D[2021-11-04]
      assert tokens.status == "some updated status"
      assert tokens.token == "some updated token"
    end

    test "update_tokens/2 with invalid data returns error changeset" do
      tokens = tokens_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_tokens(tokens, @invalid_attrs)
      assert tokens == Account.get_tokens!(tokens.id)
    end

    test "delete_tokens/1 deletes the tokens" do
      tokens = tokens_fixture()
      assert {:ok, %Tokens{}} = Account.delete_tokens(tokens)
      assert_raise Ecto.NoResultsError, fn -> Account.get_tokens!(tokens.id) end
    end

    test "change_tokens/1 returns a tokens changeset" do
      tokens = tokens_fixture()
      assert %Ecto.Changeset{} = Account.change_tokens(tokens)
    end
  end
end

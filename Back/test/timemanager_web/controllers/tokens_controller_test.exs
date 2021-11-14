defmodule TimemanagerWeb.TokensControllerTest do
  use TimemanagerWeb.ConnCase

  import Timemanager.AccountFixtures

  alias Timemanager.Account.Tokens

  @create_attrs %{
    created_at: ~D[2021-11-03],
    status: "some status",
    token: "some token"
  }
  @update_attrs %{
    created_at: ~D[2021-11-04],
    status: "some updated status",
    token: "some updated token"
  }
  @invalid_attrs %{created_at: nil, status: nil, token: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tokens", %{conn: conn} do
      conn = get(conn, Routes.tokens_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tokens" do
    test "renders tokens when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tokens_path(conn, :create), tokens: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.tokens_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "created_at" => "2021-11-03",
               "status" => "some status",
               "token" => "some token"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tokens_path(conn, :create), tokens: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tokens" do
    setup [:create_tokens]

    test "renders tokens when data is valid", %{conn: conn, tokens: %Tokens{id: id} = tokens} do
      conn = put(conn, Routes.tokens_path(conn, :update, tokens), tokens: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.tokens_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "created_at" => "2021-11-04",
               "status" => "some updated status",
               "token" => "some updated token"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tokens: tokens} do
      conn = put(conn, Routes.tokens_path(conn, :update, tokens), tokens: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tokens" do
    setup [:create_tokens]

    test "deletes chosen tokens", %{conn: conn, tokens: tokens} do
      conn = delete(conn, Routes.tokens_path(conn, :delete, tokens))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.tokens_path(conn, :show, tokens))
      end
    end
  end

  defp create_tokens(_) do
    tokens = tokens_fixture()
    %{tokens: tokens}
  end
end

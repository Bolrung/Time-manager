defmodule TimemanagerWeb.Teams_linkControllerTest do
  use TimemanagerWeb.ConnCase

  import Timemanager.TeamsManagementFixtures

  alias Timemanager.TeamsManagement.Teams_link

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all teams_link", %{conn: conn} do
      conn = get(conn, Routes.teams_link_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create teams_link" do
    test "renders teams_link when data is valid", %{conn: conn} do
      conn = post(conn, Routes.teams_link_path(conn, :create), teams_link: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.teams_link_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.teams_link_path(conn, :create), teams_link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update teams_link" do
    setup [:create_teams_link]

    test "renders teams_link when data is valid", %{conn: conn, teams_link: %Teams_link{id: id} = teams_link} do
      conn = put(conn, Routes.teams_link_path(conn, :update, teams_link), teams_link: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.teams_link_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, teams_link: teams_link} do
      conn = put(conn, Routes.teams_link_path(conn, :update, teams_link), teams_link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete teams_link" do
    setup [:create_teams_link]

    test "deletes chosen teams_link", %{conn: conn, teams_link: teams_link} do
      conn = delete(conn, Routes.teams_link_path(conn, :delete, teams_link))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.teams_link_path(conn, :show, teams_link))
      end
    end
  end

  defp create_teams_link(_) do
    teams_link = teams_link_fixture()
    %{teams_link: teams_link}
  end
end

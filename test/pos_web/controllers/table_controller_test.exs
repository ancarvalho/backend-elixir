defmodule PosWeb.TableControllerTest do
  use PosWeb.ConnCase

  alias Pos.Salon
  alias Pos.Salon.Table

  @create_attrs %{
    open: true,
    request: [],
    table: 42,
    waiter: "some waiter"
  }
  @update_attrs %{
    open: false,
    request: [],
    table: 43,
    waiter: "some updated waiter"
  }
  @invalid_attrs %{open: nil, request: nil, table: nil, waiter: nil}

  def fixture(:table) do
    {:ok, table} = Salon.create_table(@create_attrs)
    table
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tables", %{conn: conn} do
      conn = get(conn, Routes.table_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create table" do
    test "renders table when data is valid", %{conn: conn} do
      conn = post(conn, Routes.table_path(conn, :create), table: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.table_path(conn, :show, id))

      assert %{
               "id" => id,
               "open" => true,
               "request" => [],
               "table" => 42,
               "waiter" => "some waiter"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.table_path(conn, :create), table: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update table" do
    setup [:create_table]

    test "renders table when data is valid", %{conn: conn, table: %Table{id: id} = table} do
      conn = put(conn, Routes.table_path(conn, :update, table), table: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.table_path(conn, :show, id))

      assert %{
               "id" => id,
               "open" => false,
               "request" => [],
               "table" => 43,
               "waiter" => "some updated waiter"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, table: table} do
      conn = put(conn, Routes.table_path(conn, :update, table), table: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete table" do
    setup [:create_table]

    test "deletes chosen table", %{conn: conn, table: table} do
      conn = delete(conn, Routes.table_path(conn, :delete, table))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.table_path(conn, :show, table))
      end
    end
  end

  defp create_table(_) do
    table = fixture(:table)
    %{table: table}
  end
end

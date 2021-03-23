defmodule PosWeb.TableController do
  use PosWeb, :controller

  alias Pos.Salon
  alias Pos.Salon.Table

  action_fallback PosWeb.FallbackController

  def index(conn, _params) do
    tables = Salon.list_tables()
    render(conn, "index.json", tables: tables)
  end

  def create(conn, %{"table" => table_params}) do
    with {:ok, %Table{} = table} <- Salon.create_table(table_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.table_path(conn, :show, table))
      |> render("show.json", table: table)
    end
  end

  def show(conn, %{"id" => id}) do
    table = Salon.get_table!(id)
    render(conn, "show.json", table: table)
  end

  def update(conn, %{"id" => id, "table" => table_params}) do
    table = Salon.get_table!(id)

    with {:ok, %Table{} = table} <- Salon.update_table(table, table_params) do
      render(conn, "show.json", table: table)
    end
  end

  def delete(conn, %{"id" => id}) do
    table = Salon.get_table!(id)

    with {:ok, %Table{}} <- Salon.delete_table(table) do
      send_resp(conn, :no_content, "")
    end
  end
end

defmodule PosWeb.TableView do
  use PosWeb, :view
  alias PosWeb.TableView

  def render("index.json", %{tables: tables}) do
    %{data: render_many(tables, TableView, "table.json")}
  end

  def render("show.json", %{table: table}) do
    %{data: render_one(table, TableView, "table.json")}
  end

  def render("table.json", %{table: table}) do
    %{id: table.id,
      table: table.table,
      request: table.request,
      open: table.open,
      waiter: table.waiter}
  end
end

defmodule PosWeb.OrderView do
  use PosWeb, :view
  alias PosWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{id: order.id,
      waitress_id: order.waitress_id,
      table: order.table,
      requests: order.requests}
  end
end

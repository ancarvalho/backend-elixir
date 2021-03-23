defmodule PosWeb.OrderController do
  use PosWeb, :controller

  alias Pos.Requests
  alias Pos.Requests.Order

  action_fallback PosWeb.FallbackController

  def index(conn, _params) do
    orders = Requests.list_orders()
    render(conn, "index.json", orders: orders)
  end

  def create(conn, params) do
    params
    |> Requests.create_order()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %Order{} = order}, conn) do
    conn
    |> put_status(:created)
    |> render("show.json", order: order)
  end

  defp handle_response({:error, result}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(PosWeb.ErrorView)
    |> render("400.json", result: result)
  end

  def show(conn, %{"id" => id}) do
    order = Requests.get_order!(id)
    render(conn, "show.json", order: order)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Requests.get_order!(id)

    with {:ok, %Order{} = order} <- Requests.update_order(order, order_params) do
      render(conn, "show.json", order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Requests.get_order!(id)

    with {:ok, %Order{}} <- Requests.delete_order(order) do
      send_resp(conn, :no_content, "")
    end
  end
end

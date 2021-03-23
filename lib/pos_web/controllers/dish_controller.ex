defmodule PosWeb.DishController do
  use PosWeb, :controller

  alias Pos.Menu
  alias Pos.Menu.Dish

  action_fallback PosWeb.FallbackController

  def index(conn, _params) do
    dishes = Menu.list_dishes()
    render(conn, "index.json", dishes: dishes)
  end

  def create(conn, params) do
    params
    |> Menu.create_dish()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %Dish{} = dish}, conn) do
    conn
    |> put_status(:created)
    |> render("show.json", dish: dish)
  end

  defp handle_response({:error, result}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(PosWeb.ErrorView)
    |> render("400.json", result: result)
  end

  def show(conn, %{"id" => id}) do
    dish = Menu.get_dish!(id)
    render(conn, "show.json", dish: dish)
  end

  def update(conn, %{"id" => id, "dish" => dish_params}) do
    dish = Menu.get_dish!(id)

    with {:ok, %Dish{} = dish} <- Menu.update_dish(dish, dish_params) do
      render(conn, "show.json", dish: dish)
    end
  end

  def delete(conn, %{"id" => id}) do
    dish = Menu.get_dish!(id)

    with {:ok, %Dish{}} <- Menu.delete_dish(dish) do
      send_resp(conn, :no_content, "")
    end
  end
end

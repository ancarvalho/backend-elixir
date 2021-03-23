defmodule PosWeb.DishView do
  use PosWeb, :view
  alias PosWeb.DishView

  def render("index.json", %{dishes: dishes}) do
    %{data: render_many(dishes, DishView, "dish.json")}
  end

  def render("show.json", %{dish: dish}) do
    %{data: render_one(dish, DishView, "dish.json")}
  end

  def render("dish.json", %{dish: dish}) do
    %{id: dish.id,
      code: dish.code,
      name: dish.name,
      price: dish.price,
      need_prepare: dish.need_prepare,
      description: dish.description,
      category: dish.category}
  end
end

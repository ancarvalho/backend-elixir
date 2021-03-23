defmodule Pos.Menu.Dish do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "dishes" do
    field :category, :string
    field :code, :integer
    field :description, :string
    field :name, :string
    field :need_prepare, :boolean, default: false
    field :price, :decimal

    timestamps()
  end

  @doc false
  def changeset(dish, attrs) do
    dish
    |> cast(attrs, [:code, :name, :price, :need_prepare, :description, :category])
    |> validate_required([:code, :name, :price, :need_prepare, :description, :category])
  end
end

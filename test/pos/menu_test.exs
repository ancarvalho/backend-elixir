defmodule Pos.MenuTest do
  use Pos.DataCase

  alias Pos.Menu

  describe "dishes" do
    alias Pos.Menu.Dish

    @valid_attrs %{category: "some category", code: 42, description: "some description", name: "some name", need_prepare: true, price: "120.5"}
    @update_attrs %{category: "some updated category", code: 43, description: "some updated description", name: "some updated name", need_prepare: false, price: "456.7"}
    @invalid_attrs %{category: nil, code: nil, description: nil, name: nil, need_prepare: nil, price: nil}

    def dish_fixture(attrs \\ %{}) do
      {:ok, dish} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Menu.create_dish()

      dish
    end

    test "list_dishes/0 returns all dishes" do
      dish = dish_fixture()
      assert Menu.list_dishes() == [dish]
    end

    test "get_dish!/1 returns the dish with given id" do
      dish = dish_fixture()
      assert Menu.get_dish!(dish.id) == dish
    end

    test "create_dish/1 with valid data creates a dish" do
      assert {:ok, %Dish{} = dish} = Menu.create_dish(@valid_attrs)
      assert dish.category == "some category"
      assert dish.code == 42
      assert dish.description == "some description"
      assert dish.name == "some name"
      assert dish.need_prepare == true
      assert dish.price == Decimal.new("120.5")
    end

    test "create_dish/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menu.create_dish(@invalid_attrs)
    end

    test "update_dish/2 with valid data updates the dish" do
      dish = dish_fixture()
      assert {:ok, %Dish{} = dish} = Menu.update_dish(dish, @update_attrs)
      assert dish.category == "some updated category"
      assert dish.code == 43
      assert dish.description == "some updated description"
      assert dish.name == "some updated name"
      assert dish.need_prepare == false
      assert dish.price == Decimal.new("456.7")
    end

    test "update_dish/2 with invalid data returns error changeset" do
      dish = dish_fixture()
      assert {:error, %Ecto.Changeset{}} = Menu.update_dish(dish, @invalid_attrs)
      assert dish == Menu.get_dish!(dish.id)
    end

    test "delete_dish/1 deletes the dish" do
      dish = dish_fixture()
      assert {:ok, %Dish{}} = Menu.delete_dish(dish)
      assert_raise Ecto.NoResultsError, fn -> Menu.get_dish!(dish.id) end
    end

    test "change_dish/1 returns a dish changeset" do
      dish = dish_fixture()
      assert %Ecto.Changeset{} = Menu.change_dish(dish)
    end
  end
end

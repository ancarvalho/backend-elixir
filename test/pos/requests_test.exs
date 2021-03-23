defmodule Pos.RequestsTest do
  use Pos.DataCase

  alias Pos.Requests

  describe "orders" do
    alias Pos.Requests.Order

    @valid_attrs %{requests: [], table: 42, waitress_id: "some waitress_id"}
    @update_attrs %{requests: [], table: 43, waitress_id: "some updated waitress_id"}
    @invalid_attrs %{requests: nil, table: nil, waitress_id: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Requests.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Requests.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Requests.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Requests.create_order(@valid_attrs)
      assert order.requests == []
      assert order.table == 42
      assert order.waitress_id == "some waitress_id"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Requests.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Requests.update_order(order, @update_attrs)
      assert order.requests == []
      assert order.table == 43
      assert order.waitress_id == "some updated waitress_id"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Requests.update_order(order, @invalid_attrs)
      assert order == Requests.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Requests.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Requests.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Requests.change_order(order)
    end
  end
end

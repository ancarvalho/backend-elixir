defmodule PosWeb.DishControllerTest do
  use PosWeb.ConnCase

  alias Pos.Menu
  alias Pos.Menu.Dish

  @create_attrs %{
    category: "some category",
    code: 42,
    description: "some description",
    name: "some name",
    need_prepare: true,
    price: "120.5"
  }
  @update_attrs %{
    category: "some updated category",
    code: 43,
    description: "some updated description",
    name: "some updated name",
    need_prepare: false,
    price: "456.7"
  }
  @invalid_attrs %{category: nil, code: nil, description: nil, name: nil, need_prepare: nil, price: nil}

  def fixture(:dish) do
    {:ok, dish} = Menu.create_dish(@create_attrs)
    dish
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all dishes", %{conn: conn} do
      conn = get(conn, Routes.dish_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create dish" do
    test "renders dish when data is valid", %{conn: conn} do
      conn = post(conn, Routes.dish_path(conn, :create), dish: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.dish_path(conn, :show, id))

      assert %{
               "id" => id,
               "category" => "some category",
               "code" => 42,
               "description" => "some description",
               "name" => "some name",
               "need_prepare" => true,
               "price" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.dish_path(conn, :create), dish: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update dish" do
    setup [:create_dish]

    test "renders dish when data is valid", %{conn: conn, dish: %Dish{id: id} = dish} do
      conn = put(conn, Routes.dish_path(conn, :update, dish), dish: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.dish_path(conn, :show, id))

      assert %{
               "id" => id,
               "category" => "some updated category",
               "code" => 43,
               "description" => "some updated description",
               "name" => "some updated name",
               "need_prepare" => false,
               "price" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, dish: dish} do
      conn = put(conn, Routes.dish_path(conn, :update, dish), dish: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete dish" do
    setup [:create_dish]

    test "deletes chosen dish", %{conn: conn, dish: dish} do
      conn = delete(conn, Routes.dish_path(conn, :delete, dish))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.dish_path(conn, :show, dish))
      end
    end
  end

  defp create_dish(_) do
    dish = fixture(:dish)
    %{dish: dish}
  end
end

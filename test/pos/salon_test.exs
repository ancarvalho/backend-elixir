defmodule Pos.SalonTest do
  use Pos.DataCase

  alias Pos.Salon

  describe "tables" do
    alias Pos.Salon.Table

    @valid_attrs %{open: true, request: [], table: 42}
    @update_attrs %{open: false, request: [], table: 43}
    @invalid_attrs %{open: nil, request: nil, table: nil}

    def table_fixture(attrs \\ %{}) do
      {:ok, table} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Salon.create_table()

      table
    end

    test "list_tables/0 returns all tables" do
      table = table_fixture()
      assert Salon.list_tables() == [table]
    end

    test "get_table!/1 returns the table with given id" do
      table = table_fixture()
      assert Salon.get_table!(table.id) == table
    end

    test "create_table/1 with valid data creates a table" do
      assert {:ok, %Table{} = table} = Salon.create_table(@valid_attrs)
      assert table.open == true
      assert table.request == []
      assert table.table == 42
    end

    test "create_table/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Salon.create_table(@invalid_attrs)
    end

    test "update_table/2 with valid data updates the table" do
      table = table_fixture()
      assert {:ok, %Table{} = table} = Salon.update_table(table, @update_attrs)
      assert table.open == false
      assert table.request == []
      assert table.table == 43
    end

    test "update_table/2 with invalid data returns error changeset" do
      table = table_fixture()
      assert {:error, %Ecto.Changeset{}} = Salon.update_table(table, @invalid_attrs)
      assert table == Salon.get_table!(table.id)
    end

    test "delete_table/1 deletes the table" do
      table = table_fixture()
      assert {:ok, %Table{}} = Salon.delete_table(table)
      assert_raise Ecto.NoResultsError, fn -> Salon.get_table!(table.id) end
    end

    test "change_table/1 returns a table changeset" do
      table = table_fixture()
      assert %Ecto.Changeset{} = Salon.change_table(table)
    end
  end

  describe "tables" do
    alias Pos.Salon.Table

    @valid_attrs %{open: true, request: [], table: 42, waiter: "some waiter"}
    @update_attrs %{open: false, request: [], table: 43, waiter: "some updated waiter"}
    @invalid_attrs %{open: nil, request: nil, table: nil, waiter: nil}

    def table_fixture(attrs \\ %{}) do
      {:ok, table} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Salon.create_table()

      table
    end

    test "list_tables/0 returns all tables" do
      table = table_fixture()
      assert Salon.list_tables() == [table]
    end

    test "get_table!/1 returns the table with given id" do
      table = table_fixture()
      assert Salon.get_table!(table.id) == table
    end

    test "create_table/1 with valid data creates a table" do
      assert {:ok, %Table{} = table} = Salon.create_table(@valid_attrs)
      assert table.open == true
      assert table.request == []
      assert table.table == 42
      assert table.waiter == "some waiter"
    end

    test "create_table/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Salon.create_table(@invalid_attrs)
    end

    test "update_table/2 with valid data updates the table" do
      table = table_fixture()
      assert {:ok, %Table{} = table} = Salon.update_table(table, @update_attrs)
      assert table.open == false
      assert table.request == []
      assert table.table == 43
      assert table.waiter == "some updated waiter"
    end

    test "update_table/2 with invalid data returns error changeset" do
      table = table_fixture()
      assert {:error, %Ecto.Changeset{}} = Salon.update_table(table, @invalid_attrs)
      assert table == Salon.get_table!(table.id)
    end

    test "delete_table/1 deletes the table" do
      table = table_fixture()
      assert {:ok, %Table{}} = Salon.delete_table(table)
      assert_raise Ecto.NoResultsError, fn -> Salon.get_table!(table.id) end
    end

    test "change_table/1 returns a table changeset" do
      table = table_fixture()
      assert %Ecto.Changeset{} = Salon.change_table(table)
    end
  end
end

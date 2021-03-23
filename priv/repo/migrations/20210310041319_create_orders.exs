defmodule Pos.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :waiter_id, :integer
      add :table, :integer
      add :requests, :jsonb
      timestamps()
    end

  end
end

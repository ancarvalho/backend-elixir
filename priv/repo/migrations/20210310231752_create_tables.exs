defmodule Pos.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:tables, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :table, :integer
      add :requests, :jsonb
      add :open, :boolean, default: false, null: false
      add :waiter_id, :integer

      timestamps()
    end

  end
end

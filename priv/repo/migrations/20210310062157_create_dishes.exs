defmodule Pos.Repo.Migrations.CreateDishes do
  use Ecto.Migration

  def change do
    create table(:dishes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :integer
      add :name, :string
      add :price, :decimal
      add :need_prepare, :boolean, default: false, null: false
      add :description, :string
      add :category, :string

      timestamps()
    end

  end
end

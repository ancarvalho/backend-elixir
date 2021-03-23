defmodule Pos.Salon.Table do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pos.Order.Request


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tables" do
    field :open, :boolean, default: true
    embeds_many :requests, Request
    field :table, :integer
    field :waiter_id, :integer

    timestamps()
  end

  @doc false
  def changeset(table, attrs) do
    table
    |> cast(attrs, [:table, :open, :waiter_id])
    |> cast_embed(:requests, required: true)
    |> validate_required([:table, :open, :waiter_id])
  end
end

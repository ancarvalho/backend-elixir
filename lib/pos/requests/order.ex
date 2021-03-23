defmodule Pos.Requests.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pos.Order.Request
  alias Pos.Salon

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    embeds_many :requests, Request
    field :table, :integer
    field :waiter_id, :integer

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:waiter_id, :table])
    |> cast_embed(:requests, required: true)
    |> validate_required([:waiter_id, :table])
    |> add_order_to_table(attrs)
  end

  defp add_order_to_table(casted, attrs) do
    req = attrs.requests
    waiter = attrs.waiter_id
    table = attrs.table
    Enum.map(req, fn request -> Salon.create_table(%{waiter_id: waiter, table: table, requests: [request]}) end)
    casted
  end
end

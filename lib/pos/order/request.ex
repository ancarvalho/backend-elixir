defmodule Pos.Order.Request do
  use Ecto.Schema
  import Ecto.Changeset

  @derive Jason.Encoder
  @primary_key false
  embedded_schema do
    field :code, :integer
    field :quantity, :integer
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:code, :quantity])
    |> validate_required([:code, :quantity])
  end
end

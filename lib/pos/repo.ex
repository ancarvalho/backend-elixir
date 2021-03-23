defmodule Pos.Repo do
  use Ecto.Repo,
    otp_app: :pos,
    adapter: Ecto.Adapters.Postgres
end

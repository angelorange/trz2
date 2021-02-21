defmodule Trz.Repo do
  use Ecto.Repo,
    otp_app: :trz,
    adapter: Ecto.Adapters.Postgres
end

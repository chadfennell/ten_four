defmodule TenFour.Repo do
  use Ecto.Repo,
    otp_app: :ten_four,
    adapter: Ecto.Adapters.Postgres
end

defmodule ModernArt.Repo do
  use Ecto.Repo,
    otp_app: :modern_art,
    adapter: Ecto.Adapters.Postgres
end

defmodule BumblebeeStuff.Repo do
  use Ecto.Repo,
    otp_app: :bumblebee_stuff,
    adapter: Ecto.Adapters.Postgres
end

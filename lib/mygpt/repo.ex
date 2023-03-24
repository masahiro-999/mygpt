defmodule Mygpt.Repo do
  use Ecto.Repo,
    otp_app: :mygpt,
    adapter: Ecto.Adapters.SQLite3
end

defmodule MeatBar.Repo do
  use Ecto.Repo, otp_app: :meat_bar, adapter: Sqlite.Ecto
end

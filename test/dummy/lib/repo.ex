defmodule Dummy.Repo do
  use Ecto.Repo, otp_app: :aasm, adapter: Ecto.Adapters.Postgres
end

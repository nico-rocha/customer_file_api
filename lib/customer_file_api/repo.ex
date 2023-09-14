defmodule CustomerFileApi.Repo do
  use Ecto.Repo,
    otp_app: :customer_file_api,
    adapter: Ecto.Adapters.Postgres
end

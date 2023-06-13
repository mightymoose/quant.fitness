defmodule QuantFitness.Repo do
  use Ecto.Repo,
    otp_app: :quant_fitness,
    adapter: Ecto.Adapters.Postgres
end

defmodule QuantFitnessWeb.WeightTracker.WeightsController do
  use QuantFitnessWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end

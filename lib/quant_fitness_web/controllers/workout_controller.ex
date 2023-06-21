defmodule QuantFitnessWeb.WorkoutController do
  use QuantFitnessWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end

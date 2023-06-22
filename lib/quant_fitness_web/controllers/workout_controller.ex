defmodule QuantFitnessWeb.WorkoutController do
  use QuantFitnessWeb, :controller

  alias QuantFitness.Workouts

  def index(conn, _params) do
    render(conn, :index, workouts: load_workouts(conn))
  end

  defp load_workouts(conn) do
    Workouts.visible_to_user(conn.assigns.current_user)
  end
end

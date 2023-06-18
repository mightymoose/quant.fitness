defmodule QuantFitnessWeb.ExerciseController do
  use QuantFitnessWeb, :controller

  alias QuantFitness.Exercises

  def index(conn, _params) do
    render(conn, :index, exercises: load_exercises(conn))
  end

  defp load_exercises(conn) do
    Exercises.visible_to_user(conn.assigns.current_user)
  end
end

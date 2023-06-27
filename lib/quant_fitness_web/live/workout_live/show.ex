defmodule QuantFitnessWeb.WorkoutLive.Show do
  use QuantFitnessWeb, :live_view

  alias QuantFitness.Exercises

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    {:noreply,
     socket
     |> assign(:workout_id, id)
     |> assign(:exercises, load_exercises(socket))}
  end

  defp load_exercises(conn) do
    Exercises.visible_to_user(conn.assigns.current_user)
  end
end

defmodule QuantFitnessWeb.WorkoutLive.Show do
  use QuantFitnessWeb, :live_view

  alias QuantFitness.Exercises
  alias QuantFitness.Workouts

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    {:noreply,
     socket
     |> assign(:workout, load_workout(id, socket))
     |> assign(:exercises, load_exercises(socket))}
  end

  defp load_exercises(socket) do
    Exercises.visible_to_user(socket.assigns.current_user)
  end

  defp load_workout(id, socket) do
    %{current_user: current_user} = socket.assigns
    Workouts.get_workout!(id, current_user)
  end
end

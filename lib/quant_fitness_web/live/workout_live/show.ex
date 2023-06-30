defmodule QuantFitnessWeb.WorkoutLive.Show do
  use QuantFitnessWeb, :live_view

  alias QuantFitness.Exercises
  alias QuantFitness.Workouts
  alias QuantFitness.WorkoutExercises

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    {:noreply,
     socket
     |> assign(:workout, load_workout(id, socket))
     |> assign(:exercises, load_exercises(socket))}
  end

  def handle_event("add_exercise", %{"exercise_id" => exercise_id}, socket) do
    %{workout: workout, current_user: current_user} = socket.assigns

    case WorkoutExercises.create_workout_exercise(
           %{workout_id: workout.id, exercise_id: exercise_id, position: [0, 0, 0]},
           current_user
         ) do
      {:ok, _workout_exercise} ->
        {:noreply, socket}

      {:error, _} ->
        {:noreply, socket}
    end
  end

  defp load_exercises(socket) do
    Exercises.visible_to_user(socket.assigns.current_user)
  end

  defp load_workout(id, socket) do
    %{current_user: current_user} = socket.assigns
    Workouts.get_workout!(id, current_user)
  end
end

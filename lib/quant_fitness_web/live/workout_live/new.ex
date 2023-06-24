defmodule QuantFitnessWeb.WorkoutLive.New do
  use QuantFitnessWeb, :live_view

  alias QuantFitness.Workouts.Workout

  def mount(_params, _session, socket) do
    {:ok, assign(socket, workout: %Workout{user_id: socket.assigns.current_user.id})}
  end
end

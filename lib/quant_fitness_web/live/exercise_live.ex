defmodule QuantFitnessWeb.ExerciseLive do
  use QuantFitnessWeb, :live_view

  alias QuantFitness.Exercises

  def mount(%{"id" => id}, _session, socket) do
    current_user = socket.assigns.current_user
    {:ok, assign(socket, :exercise, Exercises.get!(id, current_user))}
  end
end

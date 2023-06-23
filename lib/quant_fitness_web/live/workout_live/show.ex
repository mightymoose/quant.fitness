defmodule QuantFitnessWeb.WorkoutLive.Show do
  use QuantFitnessWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    {:noreply, assign(socket, :workout_id, id)}
  end
end

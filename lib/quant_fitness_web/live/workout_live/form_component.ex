defmodule QuantFitnessWeb.WorkoutLive.FormComponent do
  use QuantFitnessWeb, :live_component

  alias QuantFitness.Workouts.Workout

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.simple_form for={@form} id="workout-form" phx-target={@myself} phx-submit="save">
        <:actions>
          <.button phx-disable-with="Saving...">Save</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{workout: workout}, socket) do
    changeset = Workout.changeset(workout, %{})
    {:ok, assign_form(socket, changeset)}
  end

  @impl true
  def handle_event("save", %{"workout" => workout}, socket) do
    save_workout(socket, workout)
  end

  defp save_workout(_socket, workout) do
    notify_parent({:saved, workout})
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

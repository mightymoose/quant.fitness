defmodule QuantFitnessWeb.WorkoutLive.FormComponent do
  use QuantFitnessWeb, :live_component

  alias QuantFitness.Workouts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.simple_form
        for={@form}
        id="workout-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <:actions>
          <.button phx-disable-with="Saving...">Save Workout</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{workout: workout} = assigns, socket) do
    changeset = Workouts.change_workout(workout)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"workout" => workout_params}, socket) do
    changeset =
      socket.assigns.workout
      |> Workouts.change_workout(workout_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", workout_params, socket) do
    save_workout(socket, workout_params)
  end

  defp save_workout(socket, workout_params) do
    # TODO: Drop this once we have fields to validate
    user_id = socket.assigns.workout.user_id

    case Workouts.create_workout(Map.put(workout_params, :user_id, user_id)) do
      {:ok, workout} ->
        {:noreply,
         socket
         |> put_flash(:info, "Workout created successfully")
         |> push_redirect(to: ~p"/workouts/#{workout.id}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end

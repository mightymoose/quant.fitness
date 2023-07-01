defmodule QuantFitness.Workouts do
  alias QuantFitness.Repo
  alias QuantFitness.Workouts.Workout
  alias QuantFitness.Workouts.WorkoutUpdates

  def visible_to_user(user) do
    Workout
    |> Workout.visible_to_user(user)
    |> Repo.all()
  end

  def get_workout!(id, user) do
    Workout
    |> Workout.visible_to_user(user)
    |> Workout.include_exercises()
    |> Repo.get!(id)
  end

  def create_workout(attrs) do
    %Workout{}
    |> Workout.changeset(attrs)
    |> Repo.insert()
  end

  def change_workout(%Workout{} = workout, attrs \\ %{}) do
    Workout.changeset(workout, attrs)
  end

  def subscribe(workout, user) do
    workout.id
    |> get_workout!(user)
    |> WorkoutUpdates.subscribe()
  end

  def unsubscribe(workout) do
    WorkoutUpdates.unsubscribe(workout.id)
  end
end

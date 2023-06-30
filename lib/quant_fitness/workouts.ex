defmodule QuantFitness.Workouts do
  alias QuantFitness.Repo
  alias QuantFitness.Workouts.Workout

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
end

defmodule QuantFitness.Workouts do
  alias QuantFitness.Repo
  alias QuantFitness.Workouts.Workout

  def visible_to_user(user) do
    Workout
    |> Workout.visible_to_user(user)
    |> Repo.all()
  end
end

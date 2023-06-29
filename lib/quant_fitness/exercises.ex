defmodule QuantFitness.Exercises do
  alias QuantFitness.Repo
  alias QuantFitness.Exercises.Exercise

  def visible_to_user(user) do
    Exercise
    |> Exercise.visible_to_user(user)
    |> Repo.all()
  end

  def get_exercise!(id, user) do
    Exercise
    |> Exercise.visible_to_user(user)
    |> Repo.get!(id)
  end
end

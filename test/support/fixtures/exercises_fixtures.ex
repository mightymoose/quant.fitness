defmodule QuantFitness.ExercisesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `QuantFitness.Exercises` context.
  """

  alias QuantFitness.Exercises.Exercise
  alias QuantFitness.Repo

  def unique_exercise_name, do: "exercise_name#{System.unique_integer()}"
  def unique_exercise_description, do: "exercise_description#{System.unique_integer()}"

  def valid_exercise_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: unique_exercise_name(),
      description: unique_exercise_description(),
      public: true,
      user_id: nil
    })
  end

  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      %Exercise{}
      |> Exercise.changeset(valid_exercise_attributes(attrs))
      |> Repo.insert()

    exercise
  end
end

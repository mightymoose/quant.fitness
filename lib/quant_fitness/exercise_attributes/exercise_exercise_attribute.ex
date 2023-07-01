defmodule QuantFitness.ExerciseAttributes.ExerciseExerciseAttribute do
  use Ecto.Schema
  import Ecto.Changeset

  alias QuantFitness.Exercises.Exercise
  alias QuantFitness.ExerciseAttributes.ExerciseAttribute

  schema "exercise_exercise_attributes" do
    belongs_to :exercise, Exercise
    belongs_to :exercise_attribute, ExerciseAttribute

    timestamps()
  end

  @doc false
  def changeset(exercise_exercise_attribute, attrs) do
    exercise_exercise_attribute
    |> cast(attrs, [:exercise_id, :exercise_attribute_id])
    |> validate_required([:exercise_id, :exercise_attribute_id])
  end
end

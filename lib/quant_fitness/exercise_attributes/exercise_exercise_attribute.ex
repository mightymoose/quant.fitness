defmodule QuantFitness.ExerciseAttributes.ExerciseExerciseAttribute do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercise_exercise_attributes" do
    field :exercise_id, :id
    field :exercise_attribute_id, :id

    timestamps()
  end

  @doc false
  def changeset(exercise_exercise_attribute, attrs) do
    exercise_exercise_attribute
    |> cast(attrs, [:exercise_id, :exercise_attribute_id])
    |> validate_required([:exercise_id, :exercise_attribute_id])
  end
end

defmodule QuantFitness.Workouts.WorkoutExerciseExerciseAttribute do
  use Ecto.Schema
  import Ecto.Changeset

  alias QuantFitness.WorkoutExercises.WorkoutExercise
  alias QuantFitness.ExerciseAttributes.ExerciseAttribute

  schema "workout_exercise_exercise_attributes" do
    field :value, :string

    belongs_to :workout_exercise, WorkoutExercise
    belongs_to :exercise_attribute, ExerciseAttribute

    timestamps()
  end

  @doc false
  def changeset(workout_exercise_exercise_attribute, attrs) do
    workout_exercise_exercise_attribute
    |> cast(attrs, [:value, :exercise_attribute_id, :workout_exercise_id])
    |> validate_required([:exercise_attribute_id, :workout_exercise_id])
  end
end

defmodule QuantFitness.WorkoutExercises.WorkoutExercise do
  use Ecto.Schema
  import Ecto.Changeset

  alias QuantFitness.Exercises.Exercise
  alias QuantFitness.Workouts.Workout

  schema "workout_exercises" do
    field :position, {:array, :integer}

    belongs_to :exercise, Exercise
    belongs_to :workout, Workout

    timestamps()
  end

  @doc false
  def changeset(exercises_workouts, attrs) do
    exercises_workouts
    |> cast(attrs, [:position, :exercise_id, :workout_id])
    |> validate_required([:position, :exercise_id, :workout_id])
    |> validate_length(:position, is: 3)
  end
end

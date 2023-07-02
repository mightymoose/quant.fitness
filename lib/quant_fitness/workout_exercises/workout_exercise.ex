defmodule QuantFitness.WorkoutExercises.WorkoutExercise do
  use Ecto.Schema
  import Ecto.Changeset

  alias QuantFitness.Exercises.Exercise
  alias QuantFitness.Workouts.Workout
  alias QuantFitness.Workouts.WorkoutExerciseExerciseAttribute

  schema "workout_exercises" do
    field :position, {:array, :integer}

    belongs_to :exercise, Exercise
    belongs_to :workout, Workout

    has_many :workout_exercise_exercise_attributes, WorkoutExerciseExerciseAttribute,
      on_delete: :delete_all

    has_many :exercise_attributes,
      through: [:workout_exercise_exercise_attributes, :exercise_attribute]

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

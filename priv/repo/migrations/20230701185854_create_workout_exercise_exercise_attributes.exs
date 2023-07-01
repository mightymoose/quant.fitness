defmodule QuantFitness.Repo.Migrations.CreateWorkoutExerciseExerciseAttributes do
  use Ecto.Migration

  def change do
    create table(:workout_exercise_exercise_attributes) do
      add :value, :string
      add :workout_exercise_id, references(:workout_exercises, on_delete: :nothing)
      add :exercise_attribute_id, references(:exercise_attributes, on_delete: :nothing)

      timestamps()
    end

    create index(:workout_exercise_exercise_attributes, [:workout_exercise_id])
    create index(:workout_exercise_exercise_attributes, [:exercise_attribute_id])
  end
end

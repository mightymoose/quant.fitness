defmodule QuantFitness.Repo.Migrations.CreateExerciseExerciseAttributes do
  use Ecto.Migration

  def change do
    create table(:exercise_exercise_attributes) do
      add :exercise_id, references(:exercises, on_delete: :nothing)
      add :exercise_attribute_id, references(:exercise_attributes, on_delete: :nothing)

      timestamps()
    end

    create index(:exercise_exercise_attributes, [:exercise_id])
    create index(:exercise_exercise_attributes, [:exercise_attribute_id])
  end
end

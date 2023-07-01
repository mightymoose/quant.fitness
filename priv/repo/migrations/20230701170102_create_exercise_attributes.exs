defmodule QuantFitness.Repo.Migrations.CreateExerciseAttributes do
  use Ecto.Migration

  def change do
    create table(:exercise_attributes) do
      add :type, :string
      add :name, :string
      add :description, :string

      timestamps()
    end
  end
end

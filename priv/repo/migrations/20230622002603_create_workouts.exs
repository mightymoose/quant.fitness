defmodule QuantFitness.Repo.Migrations.CreateWorkouts do
  use Ecto.Migration

  def change do
    create table(:workouts) do
      add :public, :boolean, default: false, null: false
      add :ended_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:workouts, [:user_id])
  end
end

defmodule QuantFitness.Repo.Migrations.CreateWeights do
  use Ecto.Migration

  def change do
    create table(:weights) do
      add :weight_in_pounds, :float
      add :recorded_at, :utc_datetime_usec
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:weights, [:user_id])
  end
end

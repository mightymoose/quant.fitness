defmodule QuantFitness.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  @app :quant_fitness

  alias QuantFitness.Repo
  alias QuantFitness.Exercises.Exercise

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end

    seed()
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  def seed() do
    now =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    exercises =
      [
        %{
          id: 1,
          name: "Pull Up",
          description: "Pull Up"
        },
        %{
          id: 2,
          name: "Chest Dip",
          description: "Chest Dip"
        },
        %{
          id: 3,
          name: "Seated Row",
          description: "Seated Row"
        },
        %{
          id: 4,
          name: "Dumbbell Bench Press",
          description: "Seated Row"
        },
        %{
          id: 5,
          name: "Barbell Squat",
          description: "Barbell Squat"
        }
      ]
      |> Enum.map(&Map.merge(&1, %{inserted_at: now, updated_at: now, public: true}))

    Exercise
    |> Repo.insert_all(exercises,
      on_conflict: {:replace_all_except, [:id, :inserted_at, :updated_at]},
      conflict_target: :id
    )
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end

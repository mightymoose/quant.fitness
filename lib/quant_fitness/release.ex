defmodule QuantFitness.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  @app :quant_fitness

  alias QuantFitness.Repo
  alias QuantFitness.Exercises.Exercise
  alias QuantFitness.ExerciseAttributes.ExerciseAttribute
  alias QuantFitness.ExerciseAttributes.ExerciseExerciseAttribute

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
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
          description: "Dummbell Bench Press"
        },
        %{
          id: 5,
          name: "Barbell Squat",
          description: "Barbell Squat"
        }
      ]
      |> Enum.map(&Map.merge(&1, %{inserted_at: now, updated_at: now, public: true}))

    exercise_attributes =
      [
        %{
          id: 1,
          name: "Weight",
          description: "Weight",
          type: "number"
        },
        %{
          id: 2,
          name: "Duration",
          description: "Duration in seconds",
          type: "duration-in-seconds"
        },
        %{
          id: 3,
          name: "Repetitions",
          description: "Repetitions",
          type: "positive-integer"
        }
      ]
      |> Enum.map(&Map.merge(&1, %{inserted_at: now, updated_at: now}))

    exercise_exercise_attributes =
      [
        %{
          id: 1,
          exercise_id: 1,
          exercise_attribute_id: 1
        },
        %{
          id: 2,
          exercise_id: 1,
          exercise_attribute_id: 3
        },
        %{
          id: 3,
          exercise_id: 2,
          exercise_attribute_id: 1
        },
        %{
          id: 4,
          exercise_id: 2,
          exercise_attribute_id: 3
        },
        %{
          id: 5,
          exercise_id: 5,
          exercise_attribute_id: 1
        },
        %{
          id: 6,
          exercise_id: 5,
          exercise_attribute_id: 3
        }
      ]
      |> Enum.map(&Map.merge(&1, %{inserted_at: now, updated_at: now}))

    Exercise
    |> Repo.insert_all(exercises,
      on_conflict: {:replace_all_except, [:id, :inserted_at, :updated_at]},
      conflict_target: :id
    )

    ExerciseAttribute
    |> Repo.insert_all(exercise_attributes,
      on_conflict: {:replace_all_except, [:id, :inserted_at, :updated_at]},
      conflict_target: :id
    )

    ExerciseExerciseAttribute
    |> Repo.insert_all(exercise_exercise_attributes,
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

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     QuantFitness.Repo.insert!(%QuantFitness.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias QuantFitness.Repo
alias QuantFitness.Exercises.Exercise

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

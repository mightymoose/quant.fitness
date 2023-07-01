defmodule QuantFitness.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias QuantFitness.Accounts.User
  alias QuantFitness.WorkoutExercises.WorkoutExercise

  schema "workouts" do
    field :ended_at, :utc_datetime
    field :public, :boolean, default: false
    field :user_id, :id

    has_many :workout_exercises, WorkoutExercise
    has_many :exercises, through: [:workout_exercises, :exercise]

    timestamps()
  end

  def include_exercises(query) do
    from(workout in query,
      preload: [workout_exercises: :exercise]
    )
  end

  @doc false
  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [:public, :ended_at, :user_id])
    |> validate_required([:public, :user_id])
  end

  def owned_by_user(query, %User{id: user_id}) do
    from(workout in query,
      where: workout.user_id == ^user_id
    )
  end

  def visible_to_user(query, %User{id: user_id}) do
    from(workout in query,
      where: workout.user_id == ^user_id or workout.public == true
    )
  end
end

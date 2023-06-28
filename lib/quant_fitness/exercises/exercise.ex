defmodule QuantFitness.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias QuantFitness.Accounts.User
  alias QuantFitness.WorkoutExercises.WorkoutExercise

  schema "exercises" do
    field :description, :string
    field :name, :string
    field :public, :boolean, default: false
    field :user_id, :id

    has_many :workout_exercises, WorkoutExercise
    has_many :workouts, through: [:workout_exercises, :workout]

    timestamps()
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name, :description, :public, :user_id])
    |> validate_required([:name, :description, :public])
  end

  def visible_to_user(query, %User{id: user_id}) do
    from(exercise in query,
      where: exercise.user_id == ^user_id or exercise.public == true
    )
  end
end

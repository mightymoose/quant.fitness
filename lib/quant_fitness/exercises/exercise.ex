defmodule QuantFitness.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias QuantFitness.Accounts.User
  alias QuantFitness.WorkoutExercises.WorkoutExercise

  alias QuantFitness.ExerciseAttributes.ExerciseExerciseAttribute

  schema "exercises" do
    field :description, :string
    field :name, :string
    field :public, :boolean, default: false
    field :user_id, :id

    has_many :workout_exercises, WorkoutExercise
    has_many :workouts, through: [:workout_exercises, :workout]

    has_many :exercise_exercise_attributes, ExerciseExerciseAttribute
    has_many :exercise_attributes, through: [:exercise_exercise_attributes, :exercise_attribute]

    timestamps()
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name, :description, :public, :user_id])
    |> validate_required([:name, :description, :public])
  end

  def include_exercise_attributes(query) do
    from(exercise in query,
      preload: :exercise_attributes
    )
  end

  def visible_to_user(query, %User{id: user_id}) do
    from(exercise in query,
      where: exercise.user_id == ^user_id or exercise.public == true
    )
  end
end

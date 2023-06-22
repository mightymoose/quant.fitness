defmodule QuantFitness.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias QuantFitness.Accounts.User

  schema "workouts" do
    field :ended_at, :utc_datetime
    field :public, :boolean, default: false
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [:public, :ended_at, :user_id])
    |> validate_required([:public, :user_id])
  end

  def visible_to_user(query, %User{id: user_id}) do
    from(workout in query,
      where: workout.user_id == ^user_id or workout.public == true
    )
  end
end

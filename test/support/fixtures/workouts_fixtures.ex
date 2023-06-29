defmodule QuantFitness.WorkoutsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `QuantFitness.Workouts` context.
  """

  alias QuantFitness.Workouts.Workout
  alias QuantFitness.Repo
  alias QuantFitness.AccountsFixtures

  def valid_workout_attributes(attrs \\ %{}) do
    user_attrs = Map.get(attrs, :user, AccountsFixtures.valid_user_attributes())
    user = AccountsFixtures.user_fixture(user_attrs)

    Enum.into(attrs, %{
      user_id: user.id,
      public: true
    })
  end

  def workout_fixture(attrs \\ %{}) do
    {:ok, workout} =
      %Workout{}
      |> Workout.changeset(valid_workout_attributes(attrs))
      |> Repo.insert()

    workout
  end
end

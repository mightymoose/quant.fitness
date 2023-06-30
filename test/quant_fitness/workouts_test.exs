defmodule QuantFitness.WorkoutsTest do
  use QuantFitness.DataCase

  alias QuantFitness.Workouts
  alias QuantFitness.Accounts

  import QuantFitness.AccountsFixtures
  import QuantFitness.WorkoutsFixtures

  describe "create_workout/1" do
    test "returns the workout with valid values" do
      attrs = valid_workout_attributes()
      assert {:ok, workout} = Workouts.create_workout(attrs)

      assert workout.user_id == attrs.user_id
      assert workout.public == attrs.public
    end

    test "returns an error with invalid values" do
      attrs = valid_workout_attributes()
      assert {:error, _changeset} = Workouts.create_workout(%{attrs | user_id: nil})
    end
  end

  describe "get_workout!/1" do
    test "returns non-public workouts belonging to the user" do
      workout = workout_fixture(%{public: false})
      user = Accounts.get_user!(workout.user_id)

      assert %{workout | exercises: [], workout_exercises: []} ==
               Workouts.get_workout!(workout.id, user)
    end

    test "returns public workouts belonging to the user" do
      workout = workout_fixture(%{public: true})
      user = Accounts.get_user!(workout.user_id)

      assert %{workout | exercises: [], workout_exercises: []} ==
               Workouts.get_workout!(workout.id, user)
    end

    test "raises trying to load non-public workouts not belonging to the user" do
      workout = workout_fixture(%{public: false})
      user = user_fixture()

      assert_raise Ecto.NoResultsError, fn ->
        Workouts.get_workout!(workout.id, user)
      end
    end

    test "returns public workouts not belonging to the user" do
      workout = workout_fixture(%{public: true})
      user = user_fixture()

      assert %{workout | exercises: [], workout_exercises: []} ==
               Workouts.get_workout!(workout.id, user)
    end
  end

  describe "visible_to_user/1" do
    test "returns non-public workouts belonging to the user" do
      workout = workout_fixture(%{public: false})
      user = Accounts.get_user!(workout.user_id)

      assert [workout] == Workouts.visible_to_user(user)
    end

    test "returns public workouts belonging to the user" do
      workout = workout_fixture(%{public: true})
      user = Accounts.get_user!(workout.user_id)

      assert [workout] == Workouts.visible_to_user(user)
    end

    test "does not return non-public workouts not belonging to the user" do
      workout_fixture(%{public: false})
      user = user_fixture()

      assert [] == Workouts.visible_to_user(user)
    end

    test "returns public workouts not belonging to the user" do
      workout = workout_fixture(%{public: true})
      user = user_fixture()

      assert [workout] == Workouts.visible_to_user(user)
    end
  end
end

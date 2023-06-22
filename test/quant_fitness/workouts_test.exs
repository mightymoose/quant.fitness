defmodule QuantFitness.WorkoutsTest do
  use QuantFitness.DataCase

  alias QuantFitness.Workouts
  alias QuantFitness.Accounts

  import QuantFitness.AccountsFixtures
  import QuantFitness.WorkoutsFeatures

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

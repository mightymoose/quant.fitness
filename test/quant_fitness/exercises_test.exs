defmodule QuantFitness.ExercisesTest do
  use QuantFitness.DataCase

  alias QuantFitness.Exercises

  import QuantFitness.AccountsFixtures
  import QuantFitness.ExercisesFixtures

  describe "visible_to_user/1" do
    test "does not return non-public exercises belonging to nobody" do
      user = user_fixture()
      exercise_fixture(%{public: false})

      assert [] == Exercises.visible_to_user(user)
    end

    test "returns public exercises belonging to nobody" do
      user = user_fixture()
      exercise = exercise_fixture(%{public: true})

      assert [exercise] == Exercises.visible_to_user(user)
    end

    test "returns non-public exercises belonging to the user" do
      user = user_fixture()
      exercise = exercise_fixture(%{public: false, user_id: user.id})

      assert [exercise] == Exercises.visible_to_user(user)
    end

    test "returns public exercises belonging to the user" do
      user = user_fixture()
      exercise = exercise_fixture(%{public: true, user_id: user.id})

      assert [exercise] == Exercises.visible_to_user(user)
    end

    test "does not return non-public exercises not belonging to the user" do
      user = user_fixture()
      other_user = user_fixture()
      exercise_fixture(%{public: false, user_id: other_user.id})

      assert [] == Exercises.visible_to_user(user)
    end

    test "returns public exercises not belonging to the user" do
      user = user_fixture()
      other_user = user_fixture()
      exercise = exercise_fixture(%{public: true, user_id: other_user.id})

      assert [exercise] == Exercises.visible_to_user(user)
    end
  end
end

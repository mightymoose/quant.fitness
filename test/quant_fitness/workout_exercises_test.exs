defmodule QuantFitness.WorkoutExercisesTest do
  use QuantFitness.DataCase

  alias QuantFitness.WorkoutExercises

  import QuantFitness.AccountsFixtures
  import QuantFitness.ExercisesFixtures
  import QuantFitness.WorkoutsFixtures

  describe "create_workout_exercise/1" do
    test "creates valid workout exercises" do
      user = user_fixture()
      exercise = exercise_fixture(%{user_id: user.id})
      workout = workout_fixture(%{user_id: user.id})

      {:ok, %{workout_exercise: workout_exercise}} =
        WorkoutExercises.create_workout_exercise(
          %{exercise_id: exercise.id, workout_id: workout.id, position: [1, 2, 3]},
          user
        )

      assert workout_exercise.exercise_id == exercise.id
      assert workout_exercise.workout_id == workout.id
      assert workout_exercise.position == [1, 2, 3]
    end

    test "returns an error without a position" do
      user = user_fixture()
      exercise = exercise_fixture(%{user_id: user.id})
      workout = workout_fixture(%{user_id: user.id})

      assert {:error, :workout_exercise, _changeset, %{}} =
               WorkoutExercises.create_workout_exercise(
                 %{exercise_id: exercise.id, workout_id: workout.id},
                 user
               )
    end

    test "returns an error without a workout id" do
      user = user_fixture()
      exercise = exercise_fixture(%{user_id: user.id})

      assert {:error, :workout_exercise, _changeset, %{}} =
               WorkoutExercises.create_workout_exercise(
                 %{exercise_id: exercise.id, position: [1, 2, 3]},
                 user
               )
    end

    test "returns an error without an exercise id" do
      user = user_fixture()
      workout = workout_fixture(%{user_id: user.id})

      assert {:error, :workout_exercise, _changeset, %{}} =
               WorkoutExercises.create_workout_exercise(
                 %{workout_id: workout.id, position: [1, 2, 3]},
                 user
               )
    end

    test "returns an error with an invalid position" do
      user = user_fixture()
      exercise = exercise_fixture(%{user_id: user.id})
      workout = workout_fixture(%{user_id: user.id})

      assert {:error, :workout_exercise, _changeset, %{}} =
               WorkoutExercises.create_workout_exercise(
                 %{exercise_id: exercise.id, workout_id: workout.id, position: [1, 2, 3, 4]},
                 user
               )
    end

    test "returns an error without a workout id that doesn't match a workout" do
      user = user_fixture()
      exercise = exercise_fixture(%{user_id: user.id})

      assert {:error, :workout, _changeset, %{}} =
               WorkoutExercises.create_workout_exercise(
                 %{exercise_id: exercise.id, workout_id: 0, position: [1, 2, 3]},
                 user
               )
    end

    test "returns an error without an exercise id that doesn't match an exercise" do
      user = user_fixture()
      workout = workout_fixture(%{user_id: user.id})

      assert {:error, :exercise, _changeset, %{}} =
               WorkoutExercises.create_workout_exercise(
                 %{exercise_id: 0, workout_id: workout.id, position: [1, 2, 3]},
                 user
               )
    end

    test "returns an error without a workout id that the user can't see" do
      user = user_fixture()
      exercise = exercise_fixture(%{user_id: user.id})
      workout = workout_fixture(%{public: false})

      assert {:error, :workout, _changeset, %{}} =
               WorkoutExercises.create_workout_exercise(
                 %{exercise_id: exercise.id, workout_id: workout.id, position: [1, 2, 3]},
                 user
               )
    end

    test "returns an error without an exercise id that the user can't see" do
      user = user_fixture()
      exercise = exercise_fixture(%{public: false})
      workout = workout_fixture(%{user_id: user.id})

      assert {:error, :exercise, _changeset, %{}} =
               WorkoutExercises.create_workout_exercise(
                 %{exercise_id: exercise.id, workout_id: workout.id, position: [1, 2, 3]},
                 user
               )
    end
  end
end

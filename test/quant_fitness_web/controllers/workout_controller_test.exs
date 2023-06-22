defmodule QuantFitnessWeb.WorkoutControllerTest do
  use QuantFitnessWeb.ConnCase, async: true

  alias QuantFitness.Accounts

  import QuantFitness.AccountsFixtures
  import QuantFitness.WorkoutsFeatures

  describe "GET /workouts" do
    test "requires a user to be logged in", %{conn: conn} do
      assert conn
             |> get("/workouts")
             |> redirected_to() == "/users/log_in"
    end

    test "shows the workout list", %{conn: conn} do
      workout = workout_fixture()
      user = Accounts.get_user!(workout.user_id)

      assert conn
             |> log_in_user(user)
             |> get(~p"/workouts")
             |> html_response(200) =~ "Workout!"
    end

    test "does not show an empty state when there are workouts", %{conn: conn} do
      workout = workout_fixture()
      user = Accounts.get_user!(workout.user_id)

      refute conn
             |> log_in_user(user)
             |> get(~p"/workouts")
             |> html_response(200) =~ "No workouts"
    end

    test "shows an empty state when the user can not see workouts", %{conn: conn} do
      assert conn
             |> log_in_user(user_fixture())
             |> get(~p"/workouts")
             |> html_response(200) =~ "No workouts"
    end
  end
end

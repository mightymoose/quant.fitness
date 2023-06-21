defmodule QuantFitnessWeb.WorkoutControllerTest do
  use QuantFitnessWeb.ConnCase, async: true

  import QuantFitness.AccountsFixtures

  describe "GET /workouts" do
    test "requires a user to be logged in", %{conn: conn} do
      assert conn
             |> get("/workouts")
             |> redirected_to() == "/users/log_in"
    end

    test "shows the workout list", %{conn: conn} do
      assert conn
             |> log_in_user(user_fixture())
             |> get(~p"/workouts")
             |> html_response(200)
    end

    test "shows an empty state when the user can not see workouts", %{conn: conn} do
      assert conn
             |> log_in_user(user_fixture())
             |> get(~p"/workouts")
             |> html_response(200) =~ "No workouts"
    end
  end
end

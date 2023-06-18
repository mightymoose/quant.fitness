defmodule QuantFitnessWeb.ExerciseControllerTest do
  use QuantFitnessWeb.ConnCase, async: true

  import QuantFitness.AccountsFixtures
  import QuantFitness.ExercisesFixtures

  describe "GET /exercises" do
    test "requires a user to be logged in", %{conn: conn} do
      assert conn
             |> get("/exercises")
             |> redirected_to() == "/users/log_in"
    end

    test "shows the exercise list", %{conn: conn} do
      exercise = exercise_fixture(%{public: true})

      assert conn
             |> log_in_user(user_fixture())
             |> get(~p"/exercises")
             |> html_response(200) =~ exercise.name
    end
  end
end

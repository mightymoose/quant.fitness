defmodule QuantFitnessWeb.ExerciseLiveTest do
  use QuantFitnessWeb.ConnCase, async: true

  import QuantFitness.AccountsFixtures
  import QuantFitness.ExercisesFixtures

  describe "GET /exercises/:id" do
    test "requires a user to be logged in", %{conn: conn} do
      exercise = exercise_fixture(%{public: true})

      assert conn
             |> get("/exercises/#{exercise.id}")
             |> redirected_to() == "/users/log_in"
    end

    test "shows the exercise", %{conn: conn} do
      exercise = exercise_fixture(%{public: true})

      assert conn
             |> log_in_user(user_fixture())
             |> get("/exercises/#{exercise.id}")
             |> html_response(200) =~ exercise.name
    end

    test "raises Ecto.NoResultsError when no matching exercise is found", %{conn: conn} do
      assert_raise Ecto.NoResultsError, fn ->
        conn
        |> log_in_user(user_fixture())
        |> get("/exercises/123")
        |> html_response(200)
      end
    end
  end
end

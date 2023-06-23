defmodule QuantFitnessWeb.WorkoutsLive.ShowTest do
  use QuantFitnessWeb.ConnCase, async: true

  import QuantFitness.AccountsFixtures
  import QuantFitness.WorkoutsFeatures

  describe "GET /workouts/:id" do
    test "redirects to the log in page when nobody is logged in", %{conn: conn} do
      assert conn
             |> get(~p"/workouts/123")
             |> redirected_to(302) == "/users/log_in"
    end

    test "renders the new workout page for logged in users", %{conn: conn} do
      workout = workout_fixture()

      assert conn
             |> log_in_user(user_fixture())
             |> get(~p"/workouts/#{workout.id}")
             |> html_response(200) =~ "Workout ##{workout.id}"
    end
  end
end

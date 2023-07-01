defmodule QuantFitnessWeb.WorkoutsLive.ShowTest do
  use QuantFitnessWeb.ConnCase, async: true

  import QuantFitness.AccountsFixtures
  import QuantFitness.WorkoutsFixtures
  import QuantFitness.ExercisesFixtures
  import Phoenix.LiveViewTest

  alias QuantFitness.Workouts

  describe "GET /workouts/:id" do
    test "lists the exercises in the workout", %{conn: conn} do
      exercise = exercise_fixture()
      workout = workout_fixture()
      user = user_fixture()

      {:ok, lv, html} =
        conn
        |> log_in_user(user)
        |> live(~p"/workouts/#{workout.id}")

      assert html
             |> Floki.find(~s|p:fl-contains("#{exercise.description}")|)
             |> length() == 1

      assert lv
             |> element(~s|button:fl-contains("Add")|)
             |> render_click()

      {:ok, _lv, html} =
        conn
        |> log_in_user(user)
        |> live(~p"/workouts/#{workout.id}")

      assert html
             |> Floki.find(~s|p:fl-contains("#{exercise.description}")|)
             |> length() == 2
    end

    test "allows adding exercises to the workout", %{conn: conn} do
      exercise = exercise_fixture()
      workout = workout_fixture()
      user = user_fixture()

      {:ok, lv, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/workouts/#{workout.id}")

      lv
      |> element(~s|button:fl-contains("Add")|)
      |> render_click()

      assert [exercise] == Workouts.get_workout!(workout.id, user).exercises
    end

    test "redirects to the log in page when nobody is logged in", %{conn: conn} do
      assert conn
             |> get(~p"/workouts/123")
             |> redirected_to(302) == "/users/log_in"
    end

    test "shows the exercises visible to a user", %{conn: conn} do
      exercise = exercise_fixture()
      workout = workout_fixture()

      assert conn
             |> log_in_user(user_fixture())
             |> get(~p"/workouts/#{workout.id}")
             |> html_response(200) =~ exercise.name
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

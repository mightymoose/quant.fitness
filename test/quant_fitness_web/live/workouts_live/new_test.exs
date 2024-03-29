defmodule QuantFitnessWeb.WorkoutsLive.NewTest do
  use QuantFitnessWeb.ConnCase, async: true
  import QuantFitness.AccountsFixtures
  import Phoenix.LiveViewTest

  alias QuantFitness.Workouts

  describe "GET /workouts/new" do
    test "redirects to the log in page when nobody is logged in", %{conn: conn} do
      assert conn
             |> get(~p"/workouts/new")
             |> redirected_to(302) == "/users/log_in"
    end

    test "renders the new workout page for logged in users", %{conn: conn} do
      assert conn
             |> log_in_user(user_fixture())
             |> get(~p"/workouts/new")
             |> html_response(200) =~ "New Workout!"
    end

    test "shows a save button", %{conn: conn} do
      assert conn
             |> log_in_user(user_fixture())
             |> get(~p"/workouts/new")
             |> html_response(200) =~ "Save"
    end

    test "creates a workout when the save button is pressed", %{conn: conn} do
      user = user_fixture()

      {:ok, lv, _html} =
        conn
        |> log_in_user(user)
        |> live("/workouts/new")

      lv
      |> form("#workout-form", %{})
      |> render_submit()

      assert [workout] = Workouts.visible_to_user(user)

      assert workout.user_id == user.id
      assert workout.public == false
    end
  end
end

defmodule QuantFitnessWeb.WeightsControllerTest do
  use QuantFitnessWeb.ConnCase, async: true

  alias QuantFitness.WeightTracker

  setup :register_and_log_in_user

  describe "GET /weight_tracker/weights/new" do
    test "renders the new weight page", %{conn: conn} do
      conn = get(conn, Routes.weights_path(conn, :new))
      response = html_response(conn, 200)
      assert response =~ "<h1>New Weight</h1>"
    end

    test "redirects if user is not logged in" do
      conn = build_conn()
      conn = get(conn, Routes.weights_path(conn, :new))
      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end
  end

  describe "POST /weight_tracker/weights" do
    test "redirects if user is not logged in" do
      conn = build_conn()
      conn = post(conn, Routes.weights_path(conn, :create, %{"weight" => %{}}))
      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end

    test "creates a weight when successful", %{conn: conn} do
      weight = %{
        "recorded_at" => %{
          "day" => "25",
          "hour" => "10",
          "minute" => "43",
          "month" => "7",
          "year" => "2022"
        },
        "weight_in_pounds" => "5"
      }

      conn = post(conn, Routes.weights_path(conn, :create, %{"weight" => weight}))

      assert redirected_to(conn) == Routes.dashboard_path(conn, :index)
      [weight] = WeightTracker.list_weights()
      assert weight.weight_in_pounds == 5
      assert weight.user_id == conn.assigns.current_user.id
      assert weight.recorded_at == ~U[2022-07-25 10:43:00.000000Z]
    end

    test "does not create a weight when there are errors", %{conn: conn} do
      weight = %{
        "recorded_at" => %{
          "day" => "25",
          "hour" => "10",
          "minute" => "43",
          "month" => "7",
          "year" => "2022"
        },
        "weight_in_pounds" => nil
      }

      conn = post(conn, Routes.weights_path(conn, :create, %{"weight" => weight}))

      assert html_response(conn, 200) =~ "New Weight"
      assert [] == WeightTracker.list_weights()
    end
  end
end

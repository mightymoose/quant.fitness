defmodule QuantFitnessWeb.DashboardLiveTest do
  use QuantFitnessWeb.ConnCase, async: true
  import QuantFitness.AccountsFixtures

  test "GET /dashboard", %{conn: conn} do
    conn =
      conn
      |> log_in_user(user_fixture())
      |> get(~p"/dashboard")

    assert html_response(conn, 200) =~ "Dashboard"
  end
end

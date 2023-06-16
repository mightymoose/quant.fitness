defmodule QuantFitnessWeb.DashboardLiveTest do
  use QuantFitnessWeb.ConnCase, async: true

  test "GET /dashboard", %{conn: conn} do
    conn = get(conn, ~p"/dashboard")
    assert html_response(conn, 200) =~ "Dashboard"
  end
end

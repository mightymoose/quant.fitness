defmodule QuantFitnessWeb.DashboardControllerTest do
  use QuantFitnessWeb.ConnCase, async: true

  setup :register_and_log_in_user

  describe "GET /dashboard" do
    test "renders the dashboard", %{conn: conn} do
      conn = get(conn, Routes.dashboard_path(conn, :index))
      response = html_response(conn, 200)
      assert response =~ "<h1>Dashboard</h1>"
    end

    test "redirects if user is not logged in" do
      conn = build_conn()
      conn = get(conn, Routes.dashboard_path(conn, :index))
      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end
  end
end

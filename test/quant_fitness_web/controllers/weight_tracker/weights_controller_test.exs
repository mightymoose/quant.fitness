defmodule QuantFitnessWeb.WeightsControllerTest do
  use QuantFitnessWeb.ConnCase, async: true

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
end

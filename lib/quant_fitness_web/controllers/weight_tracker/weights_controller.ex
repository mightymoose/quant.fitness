defmodule QuantFitnessWeb.WeightTracker.WeightsController do
  use QuantFitnessWeb, :controller

  alias QuantFitness.WeightTracker
  alias QuantFitness.WeightTracker.Weight

  def new(conn, _params) do
    changeset = WeightTracker.change_weight(%Weight{recorded_at: DateTime.utc_now()})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"weight" => weight}) do
    user = conn.assigns.current_user
    weight = Map.put(weight, "user_id", user.id)

    case WeightTracker.create_weight(weight) do
      {:ok, _weight} ->
        conn
        |> put_flash(:info, "Weight recorded")
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

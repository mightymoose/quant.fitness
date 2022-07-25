defmodule QuantFitness.WeightTrackerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `QuantFitness.WeightTracker` context.
  """

  alias QuantFitness.AccountsFixtures

  @doc """
  Generate a weight.
  """
  def weight_fixture(attrs \\ %{}) do
    user = AccountsFixtures.user_fixture()

    {:ok, weight} =
      attrs
      |> Enum.into(%{
        recorded_at: ~U[2022-07-23 23:26:00.000000Z],
        weight_in_pounds: 120.5,
        user_id: user.id
      })
      |> QuantFitness.WeightTracker.create_weight()

    weight
  end
end

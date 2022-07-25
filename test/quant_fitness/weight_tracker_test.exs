defmodule QuantFitness.WeightTrackerTest do
  use QuantFitness.DataCase

  alias QuantFitness.WeightTracker

  describe "weights" do
    alias QuantFitness.WeightTracker.Weight

    import QuantFitness.WeightTrackerFixtures
    import QuantFitness.AccountsFixtures

    @invalid_attrs %{recorded_at: nil, weight_in_pounds: nil}

    test "list_weights/0 returns all weights" do
      weight = weight_fixture()
      assert WeightTracker.list_weights() == [weight]
    end

    test "get_weight!/1 returns the weight with given id" do
      weight = weight_fixture()
      assert WeightTracker.get_weight!(weight.id) == weight
    end

    test "create_weight/1 with valid data creates a weight" do
      user = user_fixture()
      valid_attrs = %{user_id: user.id, recorded_at: ~U[2022-07-23 23:26:00.000000Z], weight_in_pounds: 120.5}

      assert {:ok, %Weight{} = weight} = WeightTracker.create_weight(valid_attrs)
      assert weight.user_id == user.id
      assert weight.recorded_at == ~U[2022-07-23 23:26:00.000000Z]
      assert weight.weight_in_pounds == 120.5
    end

    test "create_weight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WeightTracker.create_weight(@invalid_attrs)
    end

    test "update_weight/2 with valid data updates the weight" do
      weight = weight_fixture()
      update_attrs = %{recorded_at: ~U[2022-07-24 23:26:00.000000Z], weight_in_pounds: 456.7}

      assert {:ok, %Weight{} = weight} = WeightTracker.update_weight(weight, update_attrs)
      assert weight.recorded_at == ~U[2022-07-24 23:26:00.000000Z]
      assert weight.weight_in_pounds == 456.7
    end

    test "update_weight/2 with invalid data returns error changeset" do
      weight = weight_fixture()
      assert {:error, %Ecto.Changeset{}} = WeightTracker.update_weight(weight, @invalid_attrs)
      assert weight == WeightTracker.get_weight!(weight.id)
    end

    test "delete_weight/1 deletes the weight" do
      weight = weight_fixture()
      assert {:ok, %Weight{}} = WeightTracker.delete_weight(weight)
      assert_raise Ecto.NoResultsError, fn -> WeightTracker.get_weight!(weight.id) end
    end

    test "change_weight/1 returns a weight changeset" do
      weight = weight_fixture()
      assert %Ecto.Changeset{} = WeightTracker.change_weight(weight)
    end
  end
end

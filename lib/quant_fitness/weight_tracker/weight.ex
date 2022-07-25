defmodule QuantFitness.WeightTracker.Weight do
  use Ecto.Schema
  import Ecto.Changeset

  alias QuantFitness.Accounts.User

  schema "weights" do
    field :recorded_at, :utc_datetime_usec
    field :weight_in_pounds, :float

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(weight, attrs) do
    weight
    |> cast(attrs, [:weight_in_pounds, :recorded_at, :user_id])
    |> validate_number(:weight_in_pounds, greater_than: 0)
    |> validate_required([:weight_in_pounds, :recorded_at, :user_id])
  end
end

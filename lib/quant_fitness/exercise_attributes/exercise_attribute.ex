defmodule QuantFitness.ExerciseAttributes.ExerciseAttribute do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercise_attributes" do
    field :description, :string
    field :name, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(exercise_attribute, attrs) do
    exercise_attribute
    |> cast(attrs, [:type, :name, :description])
    |> validate_required([:type, :name, :description])
  end
end

defmodule QuantFitness.Workouts.WorkoutUpdates do
  alias Phoenix.PubSub

  @subject_prefix "workout_update"

  def broadcast(workout) do
    PubSub.broadcast(QuantFitness.PubSub, subject(workout), workout)
  end

  def subscribe(workout) do
    PubSub.subscribe(QuantFitness.PubSub, subject(workout))
  end

  def unsubscribe(workout) do
    PubSub.unsubscribe(QuantFitness.PubSub, subject(workout))
  end

  def subject(workout) do
    "#{@subject_prefix}:#{workout.id}"
  end
end

defmodule QuantFitness.WorkoutExercises do
  alias Ecto.Multi
  alias QuantFitness.Repo
  alias QuantFitness.Exercises
  alias QuantFitness.Workouts
  alias QuantFitness.Workouts.WorkoutUpdates
  alias QuantFitness.WorkoutExercises.WorkoutExercise
  alias QuantFitness.Workouts.WorkoutExerciseExerciseAttribute

  def create_workout_exercise(attrs, user) do
    now =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    Multi.new()
    |> Multi.run(:exercise, fn _repo, _changes ->
      ensure_exercise_exists_and_is_visible(attrs.exercise_id, user)
    end)
    |> Multi.run(:workout, fn _repo, _changes ->
      ensure_workout_exists_and_is_owned_by_user(attrs.workout_id, user)
    end)
    |> Multi.insert(:workout_exercise, WorkoutExercise.changeset(%WorkoutExercise{}, attrs))
    |> Multi.insert_all(
      :workout_exercise_exercise_attributes,
      WorkoutExerciseExerciseAttribute,
      fn %{
           workout_exercise: workout_exercise,
           exercise: exercise
         } ->
        exercise.exercise_attributes
        |> Enum.map(
          &%{
            workout_exercise_id: workout_exercise.id,
            exercise_attribute_id: &1.id,
            updated_at: now,
            inserted_at: now
          }
        )
      end
    )
    |> Repo.transaction()
    |> maybe_broadcast_workout(user)
  end

  def delete_workout_exercise(%WorkoutExercise{} = workout_exercise, user) do
    Multi.new()
    |> Multi.run(:workout, fn _repo, _changes ->
      ensure_workout_exists_and_is_owned_by_user(workout_exercise.workout_id, user)
    end)
    |> Multi.delete(:workout_exercise, workout_exercise)
    |> Repo.transaction()
    |> maybe_broadcast_workout(user)
  end

  defp ensure_exercise_exists_and_is_visible(exercise_id, user) do
    try do
      exercise = Exercises.get_exercise!(exercise_id, user)
      {:ok, exercise}
    rescue
      e in Ecto.NoResultsError -> {:error, e}
    end
  end

  defp ensure_workout_exists_and_is_owned_by_user(workout_id, user) do
    try do
      workout = Workouts.get_workout_owned_by_user!(workout_id, user)
      {:ok, workout}
    rescue
      e in Ecto.NoResultsError -> {:error, e}
    end
  end

  defp maybe_broadcast_workout({:ok, %{workout: workout}} = event, user) do
    workout = Workouts.get_workout!(workout.id, user)
    WorkoutUpdates.broadcast(workout)
    event
  end

  defp maybe_broadcast_workout(event, _user), do: event
end

defmodule MeatBar.DataImport do
  import Ecto.Query

  alias MeatBar.Repo
  alias MeatBar.Person
  alias MeatBar.Consumption

  @moduledoc """
  Utilities for importing data from a CSV file.
  """

  ##
  # External API

  @doc """
  Load consumption data from a `file` and process each record with the provided `handle_record` callback.
  """
  def load(file, handle_record) do
    File.stream!(file)
    |> CSV.decode(headers: true)
    |> Enum.each(&handle_record.(&1))
  end

  @doc """
  Push a record into the database.
  """
  def push_record(%{"person" => name, "meat-bar-type" => type, "date" => date}) do
    person = get_or_insert_person(name)
    {:ok, dt} = Ecto.DateTime.cast(date)
    Repo.insert(%Consumption{person_id: person.id, type: type, date: dt})
  end

  defp get_or_insert_person(name) do
    person = case Repo.get_by(Person, name: name) do
      nil ->
        {:ok, new_person} = Repo.insert(%Person{name: name}, on_conflict: :ignore, conflict_target: [:name])
        new_person
      existing -> existing
    end
  end
end

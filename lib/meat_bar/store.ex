defmodule MeatBar.Store do
  import Ecto.Query

  alias MeatBar.Repo
  alias MeatBar.Person
  alias MeatBar.Consumption

  @moduledoc """
  Functions for interacting with the database.
  """

  @doc "Get the names of all people who have consumed Meat Bars."
  def all_people do
    Person
    |> select([person], person.name)
    |> Repo.all
  end

  @doc "Get all consumption records sorted by oldest first."
  def all_consumption do
    query = from c in Consumption,
            join: p in Person,
            order_by: c.date,
            select: %{person: p.name, type: c.type, date: c.date}
    Repo.all(query)
  end

  @doc "Aggregate consumptions per day, sorted by oldest first."
  def consumption_per_day do
    query = """
      SELECT strftime('%Y-%m', date) AS month, strftime('%Y-%m-%d', date) AS per_day, COUNT(*) AS total
      FROM consumption
      GROUP BY 1, 2
      ORDER BY 1
    """
    {:ok, %{rows: results}} = Ecto.Adapters.SQL.query(Repo, query, [])
    results
  end

  @doc "Track a new consumption record, adding a user if necessary."
  def track_consumption(%{"person" => name, "meat-bar-type" => type, "date" => date}) do
    {:ok, dt} = Ecto.DateTime.cast(date)
    person = get_or_insert_person(name)
    Repo.insert(%Consumption{person_id: person.id, type: type, date: dt})
  end

  defp get_or_insert_person(name) do
    case Repo.get_by(Person, name: name) do
      nil ->
        {:ok, new_person} = Repo.insert(%Person{name: name}, on_conflict: :ignore, conflict_target: [:name])
        new_person
      existing -> existing
    end
  end
end

defmodule MeatBar.ModelTest do
  use ExUnit.Case

  alias MeatBar.Repo
  alias MeatBar.Person
  alias MeatBar.Consumption

  import Ecto.Query

  setup_all do
    pid = case MeatBar.start(nil, nil) do
      {:ok, pid} -> pid
      {:error, {:already_started, pid}} -> pid
    end
    {:ok, [pid: pid]}
  end

  test "data models are wired up correctly" do
    # Insert a new person
    {:ok, person} = Repo.insert(%Person{name: "daines"})
    ["daines"] = Person |> select([person], person.name) |> Repo.all

    # Can insert a new consumption
    {:ok, bison_time} = Ecto.DateTime.cast("2015-01-08T09:00:00.000Z")
    Repo.insert(%Consumption{person_id: person.id, type: "bison", date: bison_time})
    {:ok, lamb_time} = Ecto.DateTime.cast("2015-01-09T10:00:00.000Z")
    Repo.insert(%Consumption{person_id: person.id, type: "lamb", date: lamb_time})
    assert ["bison", "lamb"] == Consumption
                              |> select([consumption], consumption.type)
                              |> where([consumption], consumption.person_id == ^person.id)
                              |> Repo.all

    # Load all of a person's consumption
    query = from p in Person, where: p.id == ^person.id, preload: [:consumption]
    types = query
            |> Repo.all
            |> Enum.map(fn(person) -> person.consumption end)
            |> List.flatten
            |> Enum.map(fn(ate) -> ate.type end)
    assert ["bison", "lamb"] == types
  end
end

defmodule MeatBar.API do
  use Maru.Router

  import Ecto.Query

  @moduledoc """
  Defines the routes supported by this application.
  """

  namespace :people do
    get do
      persons = MeatBar.Person
                |> select([person], person.name)
                |> MeatBar.Repo.all
      json(conn, persons)
    end
  end

  namespace :consumption do
    get do
      query = from c in MeatBar.Consumption,
              join: p in MeatBar.Person,
              order_by: c.date,
              select: %{person: p.name, type: c.type, date: c.date}
      consumed = MeatBar.Repo.all(query)
      json(conn, consumed)
    end

    params do
      requires :name, type: String
      requires :type, type: String
      requires :date, type: String
    end
    post do
    end
  end

  namespace :reports do
    namespace :streaks do
      get do
        json(conn, [])
      end
    end

    namespace :monthly_peaks do
      get do
        json(conn, [])
      end
    end
  end

  def error(conn, e) do
    json(conn, %{error: e})
  end
end

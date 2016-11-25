defmodule MeatBar.API do
  use Maru.Router

  @moduledoc """
  Defines the routes supported by this application.
  """

  # Adds parser which allows route to accept JSON POST.
  before do
    plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]
  end

  namespace :people do
    desc "All people."
    get do
      json(conn, MeatBar.Store.all_people())
    end
  end

  namespace :consumption do
    desc "All meat bars consumptions."
    get do
      json(conn, MeatBar.Store.all_consumption())
    end

    desc "Adds a meat consumption."
    params do
      requires "person", type: String
      requires "meat-bar-type", type: String
      requires "date", type: String
    end
    post do
      {:ok, _} = MeatBar.Store.track_consumption(params)
      conn |> put_status(204) |> json([])
    end
  end

  namespace :reports do
    namespace :streaks do
      desc """
      All streaks of days when more and more meat bars were eaten
      than the day before.
      """
      get do
        streaks = MeatBar.Store.consumption_per_day()
                  |> MeatBar.Report.streaks()
        json(conn, streaks)
      end
    end

    namespace :monthly_peaks do
      desc """
      For each month, which day of the month has people eat the most bars.
      """
      get do
        peaks = MeatBar.Store.consumption_per_day()
                |> MeatBar.Report.monthly_peaks()
        json(conn, peaks)
      end
    end
  end

  def error(conn, e) do
    json(conn, %{error: e})
  end
end

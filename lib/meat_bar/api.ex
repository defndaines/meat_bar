defmodule MeatBar.API do
  use Maru.Router

  @moduledoc """
  Defines the routes supported by this application.
  """

  before do
    plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]
  end

  namespace :people do
    get do
      json(conn, MeatBar.Store.all_people())
    end
  end

  namespace :consumption do
    get do
      json(conn, MeatBar.Store.all_consumption())
    end

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

defmodule MeatBar.API do
  use Maru.Router

  @moduledoc """
  Defines the routes supported by this application.
  """

  namespace :people do
    get do
      json(conn, [])
    end
  end

  namespace :consumption do
    get do
      json(conn, [])
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

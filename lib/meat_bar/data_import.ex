defmodule MeatBar.DataImport do

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
end

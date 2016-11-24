defmodule MeatBar.Report do
  @moduledoc """
  Functions for generating analytical reports against consumption data.
  """

  @doc "For each month, which day of the month has people eat the most bars on."
  def monthly_peaks(data) do
    data
    |> Enum.group_by(fn([month, _, _]) -> month end, fn([_, date, cnt]) -> {date, cnt} end)
    |> Enum.map(fn({month, vals}) -> {month, peak_date(vals)} end)
    |> Enum.into(%{})
  end

  defp peak_date(count_tuples) do
    {peak, _} = Enum.max_by(count_tuples, fn({date, cnt}) -> cnt end)
    peak
  end
end

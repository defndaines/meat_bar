defmodule MeatBar.Report do
  @moduledoc """
  Functions for generating analytical reports against consumption data.
  """

  @doc """
  All streaks of days when more and more meat bars were eaten than the day
  before (ignoring days with no consumption).
  """
  def streaks(data) do
    do_streaks(data, [], [])
  end

  @doc "For each month, which day of the month has people eat the most bars on."
  def monthly_peaks(data) do
    data
    |> Enum.group_by(fn([month, _, _]) -> month end, fn([_, date, cnt]) -> {date, cnt} end)
    |> Enum.map(fn({month, vals}) -> {month, peak_date(vals)} end)
    |> Enum.into(%{})
  end

  # Expects the three-element list returned by Store.consumption_per_day
  # Reduces over the full list, assembling streaks into the final accumulator.
  defp do_streaks([], [], acc), do: acc
  defp do_streaks([], last, acc), do: acc ++ [finalize_streak(last)]
  defp do_streaks([[_, date, cnt] | rest], [], acc) do
    do_streaks(rest, [{date, cnt}], acc)
  end
  defp do_streaks([[_, date, cnt] | rest], [{_, prev_cnt} | _] = last, acc) when cnt <= prev_cnt do
    do_streaks(rest, [{date, cnt}], acc ++ [finalize_streak(last)])
  end
  defp do_streaks([[_, date, cnt] | rest], last, acc) do
    do_streaks(rest, [{date, cnt} | last], acc)
  end

  # When a streak is complete, reduce to just the dates and put back in order.
  defp finalize_streak(list) do
    list |> Enum.map(fn({date, _}) -> date end) |> Enum.reverse
  end

  defp peak_date(count_tuples) do
    {peak, _} = Enum.max_by(count_tuples, fn({_, cnt}) -> cnt end)
    peak
  end
end

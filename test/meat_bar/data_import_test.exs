defmodule MeatBar.DataImportTest do
  use ExUnit.Case, async: true
  doctest MeatBar.DataImport

  test "reads data from provided file" do
    filename = "test/data.csv"

    MeatBar.DataImport.load(filename, fn(%{"person" => person, "meat-bar-type" => type, "date" => date}) -> IO.puts("#{person},#{type},#{date}") end)
  end
end

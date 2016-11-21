defmodule MeatBar.DataImportTest do
  use ExUnit.Case, async: true
  doctest MeatBar.DataImport

  test "reads data from provided file" do
    filename = "test/data.csv"

    MeatBar.DataImport.load(filename, &MeatBar.DataImport.push_record/1)
  end
end

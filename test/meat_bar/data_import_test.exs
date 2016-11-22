defmodule MeatBar.DataImportTest do
  use ExUnit.Case, async: true
  doctest MeatBar.DataImport

  test "reads data from provided file" do
    filename = "test/data.csv"

    MeatBar.DataImport.load(filename, &MeatBar.Store.track_consumption/1)
    assert ["ashton", "bob", "chuck"] = MeatBar.Store.all_people()
  end
end

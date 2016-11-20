defmodule MeatBar.Person do
  use Ecto.Model

  schema "person" do
    has_many :consumption, MeatBar.Consumption
    field :name, :string
  end
end

defmodule MeatBar.Consumption do
  use Ecto.Model

  schema "consumption" do
    belongs_to :person, MeatBar.Person
    field :type, :string
    field :date, Ecto.DateTime
  end
end

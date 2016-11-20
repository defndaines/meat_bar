defmodule MeatBar.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  def change do
    create table(:person) do
      add :name, :string
    end
  end
end

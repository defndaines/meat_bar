defmodule MeatBar.Repo.Migrations.CreateConsumption do
  use Ecto.Migration

  def change do
    create table(:consumption) do
      add :person_id, references(:person)
      add :type, :string
      add :date, :datetime
    end
  end
end

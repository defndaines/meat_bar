defmodule MeatBar.Repo.Migrations.CreateConsumption do
  use Ecto.Migration

  def change do
    create table(:consumption) do
      add :people_id, references(:people)
      add :type, :string
      add :date, :datetime

      timestamps
    end
  end
end

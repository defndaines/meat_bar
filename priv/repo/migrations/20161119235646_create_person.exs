defmodule MeatBar.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  # NOTE: Ecto doesn't support uniqueness constraints for SQLite because it
  # cannot get enough information from the DB when the contraint is violated.
  def change do
    create table(:person) do
      add :name, :string
    end
  end
end

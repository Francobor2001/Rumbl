defmodule Rumbl.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false

      timestamps()
    end
    create unique_index(:categories, [:name]) #dont allow duplicated names
  end
end

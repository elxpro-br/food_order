defmodule FoodOrder.Repo.Migrations.AddMap do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :lat, :float
      add :lng, :float
    end
  end
end

defmodule FoodOrder.Repo.Migrations.AddLatLng do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :latitude, :float
      add :longitude, :float
    end
  end
end

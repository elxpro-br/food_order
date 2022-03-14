defmodule FoodOrder.Repo.Migrations.AddProductImage do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :product_url, :string
    end
  end
end

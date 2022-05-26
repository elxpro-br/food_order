defmodule FoodOrder.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer, null: false, default: 0
      add :product_id, references(:products, on_delete: :nothing, type: :binary_id)
      add :order_id, references(:orders, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:items, [:product_id])
    create index(:items, [:order_id])
  end
end

defmodule FoodOrder.Orders.Data.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias FoodOrder.Products.Product

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "items" do
    field :quantity, :integer
    belongs_to :product, Product
    field :order_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:quantity, :product_id])
    |> validate_required([:quantity, :product_id])
  end
end

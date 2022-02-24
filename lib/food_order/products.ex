defmodule FoodOrder.Products do
  alias FoodOrder.Products.Product
  alias FoodOrder.Repo

  def list_products, do: Repo.all(Product)
  def get!(id), do: Repo.get!(Product, id)

  def create_product(attrs \\ %{}) do
    attrs
    |> Product.changeset()
    |> Repo.insert()
  end

  def update_product(product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def change_product(product, params \\ %{}), do: Product.changeset(product, params)
end

defmodule FoodOrder.ProductsTest do
  use FoodOrder.DataCase
  alias FoodOrder.Products
  alias FoodOrder.Products.Product

  test "list_products/0" do
    assert Products.list_products() == []
  end

  test "create product" do
    payload = %{name: "pizza", size: "small", price: 100, description: "abobora"}

    assert {:ok, %Product{} = product} = Products.create_product(payload)

    assert product.description == payload.description
    assert product.name == payload.name
    assert product.price == payload.price
    assert product.size == payload.size
  end
end

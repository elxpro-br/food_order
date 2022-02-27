defmodule FoodOrder.ProductsTest do
  use FoodOrder.DataCase
  alias FoodOrder.Products
  alias FoodOrder.Products.Product

  test "list_products/0" do
    assert Products.list_products() == []
  end

  test "get!/1" do
    payload = %{name: "pizza", size: "small", price: 100, description: "abobora"}
    {:ok, product} = Products.create_product(payload)
    assert Products.get!(product.id).name == product.name
  end

  test "delete/1" do
    payload = %{name: "pizza", size: "small", price: 100, description: "abobora"}
    {:ok, product} = Products.create_product(payload)
    assert {:ok, %Product{}} = Products.delete(product.id)
    assert_raise Ecto.NoResultsError, fn -> Products.get!(product.id) end
  end

  test "create product" do
    payload = %{name: "pizza", size: "small", price: 100, description: "abobora"}

    assert {:ok, %Product{} = product} = Products.create_product(payload)

    assert product.description == payload.description
    assert product.name == payload.name
    assert product.price == %Money{amount: 100, currency: :BRL}
    assert product.size == payload.size
  end

  test "update product" do
    payload = %{name: "pizza", size: "small", price: 100, description: "abobora"}

    assert {:ok, product} = Products.create_product(payload)
    assert {:ok, %Product{} = product} = Products.update_product(product, %{name: "abobora"})

    assert product.description == payload.description
    assert product.name == "abobora"
    assert product.price == %Money{amount: 100, currency: :BRL}
    assert product.size == payload.size
  end

  test "given a product with the same name should throw an error message" do
    payload = %{name: "pizza", size: "small", price: 100, description: "abobora"}

    assert {:ok, %Product{} = _product} = Products.create_product(payload)
    assert {:error, changeset} = Products.create_product(payload)
    assert "has already been taken" in errors_on(changeset).name
    assert %{name: ["has already been taken"]} = errors_on(changeset)
  end
end

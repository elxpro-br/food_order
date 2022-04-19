defmodule FoodOrder.Factory do
  use ExMachina.Ecto, repo: FoodOrder.Repo
  alias FoodOrder.Products.Product

  def product_factory do
    %Product{
      description: Faker.Food.description(),
      name: Faker.Food.dish() <> (:rand.uniform(1_000) |> Integer.to_string()),
      price: :rand.uniform(10_000),
      size: "small"
    }
  end
end

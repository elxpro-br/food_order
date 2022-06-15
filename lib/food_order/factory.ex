defmodule FoodOrder.Factory do
  use ExMachina.Ecto, repo: FoodOrder.Repo
  alias FoodOrder.Accounts.User
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Products.Product
  alias FoodOrder.Repo
  alias FoodOrder.Orders.Services.GetLatLng
  @size ~w/small medium large/s

  def product_factory do
    %Product{
      description: Faker.Food.description(),
      name: Faker.Food.dish() <> (:rand.uniform(1_000) |> Integer.to_string()),
      price: :rand.uniform(10_000),
      size: @size |> Enum.shuffle() |> hd
    }
  end

  def order_factory(attrs) do
    user =
      if attrs[:user] do
        attrs[:user]
      else
        %User{}
        |> User.registration_changeset(%{
          email: "test-#{:rand.uniform(10_000)}@elxpro.com",
          password: "adm@Elxpro.coM1"
        })
        |> Repo.insert!()
      end

    product_1 = insert(:product)
    product_2 = insert(:product)

    total_price = product_1.price |> Money.add(product_1.price) |> Money.add(product_2.price)
    address = Faker.Address.PtBr.street_address()
    %{latitude: latitude, longitude: longitude} = GetLatLng.execute(address)

    %Order{
      user_id: user.id,
      address: address,
      phone_number: Faker.Phone.PtBr.phone(),
      latitude: latitude,
      longitude: longitude,
      items: [
        %{
          quantity: 2,
          product_id: product_1.id
        },
        %{
          quantity: 1,
          product_id: product_2.id
        }
      ],
      total_quantity: 3,
      total_price: total_price
    }
  end
end

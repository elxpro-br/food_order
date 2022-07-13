defmodule FoodOrder.Factory do
  use ExMachina.Ecto, repo: FoodOrder.Repo
  alias FoodOrder.Accounts.User
  alias FoodOrder.Orders.Data.Order
  alias FoodOrder.Products.Product
  alias FoodOrder.Repo
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

    locations = [
      %{latitude: -22.74470633413637, longitude: -47.34198859499476},
      %{latitude: -22.7315657718667, longitude: -47.3310022672889},
      %{latitude: -22.746131138472663, longitude: -47.36842444603697},
      %{latitude: -22.746131138472663, longitude: -47.36842444603697},
      %{latitude: -22.734297, longitude: -47.334784}
    ]

    location = locations |> Enum.shuffle() |> hd

    product_1 = insert(:product)
    product_2 = insert(:product)

    total_price = product_1.price |> Money.add(product_1.price) |> Money.add(product_2.price)

    %Order{
      user_id: user.id,
      address: Faker.Address.PtBr.street_address(),
      phone_number: Faker.Phone.PtBr.phone(),
      latitude: location.latitude,
      longitude: location.longitude,
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

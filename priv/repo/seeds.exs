alias FoodOrder.Accounts
alias FoodOrder.Products
import FoodOrder.Factory

Accounts.register_user(%{
  email: "adm@elxpro.com",
  password: "adm@elxpro.coM1",
  role: "ADMIN"
})

user = Accounts.register_user(%{
  email: "user@elxpro.com",
  password: "user@elxpro.coM1",
  role: "USER"
})

Enum.each(1..200, fn _ ->
  image = :rand.uniform(4)

  %{
    name: Faker.Food.dish(),
    description: Faker.Food.description(),
    price: :random.uniform(10_000),
    size: "small",
    product_url: %Plug.Upload{
      content_type: "image/png",
      filename: "product_#{image}.jpg",
      path: "priv/static/images/product_#{image}.jpg"
    }
  }
  |> Products.create_product()
end)

insert(:order)
insert(:order)
insert(:order)
insert(:order)

alias FoodOrder.Accounts
alias FoodOrder.Products

Accounts.register_user(%{
  email: "adm@elxpro.com",
  password: "adm@elxpro.coM1",
  role: "ADMIN"
})

Accounts.register_user(%{
  email: "user@elxpro.com",
  password: "user@elxpro.coM1",
  role: "USER"
})

{:ok, product} =
  %{
    name: Faker.Food.dish(),
    description: Faker.Food.description(),
    price: :random.uniform(10_000),
    size: "small",
    product_url: %Plug.Upload{
      content_type: "image/png",
      filename: "logo.png",
      path: "priv/static/images/logo.png"
    }
  }
  |> Products.create_product()

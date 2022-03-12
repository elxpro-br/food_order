alias FoodOrder.Accounts

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

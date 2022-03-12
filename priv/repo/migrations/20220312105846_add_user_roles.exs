defmodule FoodOrder.Repo.Migrations.AddUserRoles do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE roles as ENUM ('USER', 'ADMIN')"
    drop_query = "DROP TYPE roles"
    execute(create_query, drop_query)

    alter table(:users) do
      add :role, :roles, default: "USER", null: false
    end
  end
end

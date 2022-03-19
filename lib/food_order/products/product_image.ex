defmodule FoodOrder.Products.ProductImage do
  use Waffle.Definition
  use Waffle.Ecto.Definition

  @extension_whitelist ~w(.png .jpeg .jpg)

  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname() |> String.downcase()

    case Enum.member?(@extension_whitelist, file_extension) do
      true -> :ok
      false -> {:error, "file type is invalid"}
    end
  end

  def storage_dir(_, {_file, product}) do
    if Mix.env() == :prod do
      "products/#{product.name}"
    else
      "priv/static/uploads/products/#{product.name}"
    end
  end
end

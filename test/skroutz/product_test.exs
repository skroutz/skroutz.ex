defmodule Skroutz.ProductTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    token = "token"

    {:ok, skroutz} = Skroutz.new(token)
    {:ok, [skroutz: skroutz, product_id: 21076704]}
  end

  test "find returns a Map", context do
    use_cassette "products_find" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Product.find(context[:product_id])

      assert resource |> is_map
    end
  end
end

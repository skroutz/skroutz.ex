defmodule Skroutz.SkuTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    token = "token"

    {:ok, skroutz} = Skroutz.new(token)
    {:ok, [skroutz: skroutz, sku_id: 7423345]}
  end

  test "find returns a Map", context do
    use_cassette "skus_find" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Sku.find(context[:sku_id])

      assert resource |> is_map
    end
  end

  test "similar, skus is a list", context do
    use_cassette "skus_similar" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Sku.similar(context[:sku_id])

      assert resource |> Map.get("skus") |> is_list
    end
  end

  test "products returns a Map", context do
    use_cassette "skus_products" do
      {:ok, resource} =  context[:skroutz] |> Skroutz.Sku.products(context[:sku_id])

      assert resource |> is_map
    end
  end

  test "products, products key contains a List", context do
    use_cassette "skus_products" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Sku.products(context[:sku_id])

      assert resource |> Map.get("products") |> is_list
    end
  end

  test "reviews returns a Map", context do
    use_cassette "skus_reviews" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Sku.reviews(context[:sku_id])

      assert resource |> is_map
    end
  end

  test "reviews, reviews key contains a List", context do
    use_cassette "skus_reviews" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Sku.reviews(context[:sku_id])

      assert resource |> Map.get("reviews") |> is_list
    end
  end

  test "specifications, returns a Map", context do
    use_cassette "skus_specifications" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Sku.specifications(context[:sku_id])

      assert resource |> is_map
    end
  end

  test "specifications, specifications key contains a List", context do
    use_cassette "skus_specifications" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Sku.specifications(context[:sku_id])

      assert resource |> is_map
    end
  end

  test "price_history, returns a Map", context do
    use_cassette "skus_price_history" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Sku.price_history(context[:sku_id])

      assert resource |> is_map
    end
  end
end

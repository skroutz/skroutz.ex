defmodule Skroutz.ShopTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    token = "token"

    {:ok, skroutz} = Skroutz.new(token)
    {:ok, [skroutz: skroutz, shop_id: 452, location_id: 2500, shop_uid: "059157"]}
  end

  test "search returns a Map", context do
    use_cassette "shops_search" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Shop.search("kotso")

      assert resource |> is_map
    end
  end

  test "find, returns a Map", context do
    use_cassette "shops_find" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Shop.find(context[:shop_id])

      assert resource |> is_map
    end
  end

  test "reviews, is a Map", context do
    use_cassette "shops_reviews" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Shop.reviews(context[:shop_id])

      assert resource |> is_map
    end
  end

  test "locations, returns a Map", context do
    use_cassette "shops_locations" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Shop.locations(context[:shop_id])

      assert resource |> is_map
    end
  end

  test "locations, locations key contains a List", context do
    use_cassette "shops_locations" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Shop.locations(context[:shop_id])

      assert resource |> Map.get("locations") |> is_list
    end
  end

  test "location, returns a Map", context do
    use_cassette "shops_location" do
      {:ok, resource} = context[:skroutz]
                        |> Skroutz.Shop.location(context[:shop_id], context[:location_id])

      assert resource |> is_map
    end
  end

  test "product_search, returns a Map", context do
    use_cassette "shops_product_search" do
      {:ok, resource} = context[:skroutz]
                        |> Skroutz.Shop.product_search(context[:shop_id],
                                                         shop_uid: context[:shop_uid])

      assert resource |> is_map
    end
  end
end

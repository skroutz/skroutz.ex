defmodule Skroutz.ManufacturerTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    token = "token"

    {:ok, skroutz} = Skroutz.new(token)
    {:ok, [skroutz: skroutz, manufacturer_id: 28]}
  end

  test "all returns a Map", context do
    use_cassette "manufacturers_all" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Manufacturer.all

      assert resource |> is_map
    end
  end

  test "all, manufacturers key contains a List", context do
    use_cassette "manufacturers_all" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Manufacturer.all

      assert resource |> Map.get("manufacturers") |> is_list
    end
  end

  test "find returns a Map", context do
    use_cassette "manufacturers_find" do
      {:ok, resource} = context[:skroutz]
                        |> Skroutz.Manufacturer.find(context[:manufacturer_id])

      assert resource |> is_map
    end
  end

  test "categories is a Map", context do
    use_cassette "manufacturers_categories" do
      {:ok, resource} = context[:skroutz]
                        |> Skroutz.Manufacturer.categories(context[:manufacturer_id])

      assert resource |> is_map
    end
  end

  test "categories, categories key contains a List", context do
    use_cassette "manufacturers_categories" do
      {:ok, resource} = context[:skroutz]
                        |> Skroutz.Manufacturer.categories(context[:manufacturer_id])

      assert resource |> Map.get("categories") |> is_list
    end
  end

  test "skus returns a Map", context do
    use_cassette "manufacturers_skus" do
      {:ok, resource} = context[:skroutz]
                        |> Skroutz.Manufacturer.skus(context[:manufacturer_id])

      assert resource |> is_map
    end
  end

  test "skus, skus key contains a List", context do
    use_cassette "manufacturers_skus" do
      {:ok, resource} = context[:skroutz]
                        |> Skroutz.Manufacturer.skus(context[:manufacturer_id])

      assert resource |> Map.get("skus") |> is_list
    end
  end
end

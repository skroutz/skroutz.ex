defmodule Skroutz.CategoryTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    token = "token"

    {:ok, skroutz} = Skroutz.new(token)
    {:ok, [skroutz: skroutz]}
  end

  test "all returns a Map", context do
    use_cassette "categories_all" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Category.all

      assert resource |> is_map
    end
  end

  test "all, categories is a list", context do
    use_cassette "categories_all" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Category.all

      assert resource |> Map.get("categories") |> is_list
    end
  end

  test "find returns a Map", context do
    use_cassette "categories_find" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Category.find(40)

      assert resource |> is_map
    end
  end

  test "find returns the correct category", context do
    use_cassette "categories_find" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Category.find(40)

      assert resource |> Map.get("category") |> Map.get("id") == 40
    end
  end

  test "root returns a Map", context do
    use_cassette "categories_root" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Category.root

      assert resource |> is_map
    end
  end

  test "parent returns a Map", context do
    use_cassette "categories_parent" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Category.parent(1269)

      assert resource |> is_map
    end
  end

  test "children returns a Map", context do
    use_cassette "categories_children" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Category.children(1269)

      assert resource |> is_map
    end
  end

  test "children, categories is a list", context do
    use_cassette "categories_children" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Category.children(1269)

      assert resource |> Map.get("categories") |> is_list
    end
  end

  test "manufacturers returns a list", context do
    use_cassette "categories_manufacturers" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Category.manufacturers(40)

      assert resource |> Map.get("manufacturers") |> is_list
    end
  end

  test "favorites returns a list", context do
    use_cassette "categories_favorites" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Category.favorites(40)

      assert resource |> Map.get("favorites") |> is_list
    end
  end
end

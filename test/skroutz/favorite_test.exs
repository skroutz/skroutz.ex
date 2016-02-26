defmodule Skroutz.FavoriteTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Skroutz.Favorite

  setup_all do
    token = "token"

    {:ok, skroutz} = Skroutz.new(token)
    {:ok, [skroutz: skroutz, favorite_id: 254728, sku_id: 7504828]}
  end

  test "all returns a Map", context do
    use_cassette "favorites_all" do
      {:ok, resource} = context[:skroutz] |> Favorite.all

      assert resource |> is_map
    end
  end

  test "all, favorites is a list", context do
    use_cassette "favorites_all" do
      {:ok, resource} = context[:skroutz] |> Favorite.all

      assert resource |> Map.get("favorites") |> is_list
    end
  end

  test "find returns a Map", context do
    use_cassette "favorites_find" do
      {:ok, resource} = context[:skroutz] |> Favorite.find(context[:favorite_id])

      assert resource |> is_map
    end
  end

  test "find returns the correct favorite", context do
    use_cassette "favorite_find" do
      {:ok, resource} = context[:skroutz] |> Favorite.find(context[:favorite_id])

      assert resource |> Map.get("favorite") |> Map.get("id")
             == context[:favorite_id]
    end
  end

  test "create returns a Map", context do
    use_cassette "favorites_create" do
      {:ok, resource} = context[:skroutz] |> Favorite.create(%{sku_id: context[:sku_id]})

      assert resource |> is_map
    end
  end

  test "delete, returns a Map", context do
    use_cassette "favorites_delete" do
      {:ok, resource} = context[:skroutz] |> Favorite.delete(context[:favorite_id])

      assert resource |> is_map
    end
  end

  test "create, favorite is assigned the correct sku_id", context do
    use_cassette "favorites_create" do
      {:ok, resource} = context[:skroutz] |> Favorite.create(%{sku_id: context[:sku_id]})

      assert resource |> Map.get("favorite") |> Map.get("sku_id")
             == context[:sku_id]
    end
  end

  test "update, returns a Map", context do
    use_cassette "favorites_update" do
      {:ok, resource} = context[:skroutz]
                        |> Favorite.update(context[:favorite_id], %{have_it: true})

      assert resource |> is_map
    end
  end
end

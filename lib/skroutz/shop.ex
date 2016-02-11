defmodule Skroutz.Shop do
  @moduledoc """
  Groups functions handling [Shop](http://developer.skroutz.gr/api/v3/shop)
  endpoints
  """

  @doc """
  Performs shop search with the provided query
  @see http://developer.skroutz.gr/api/v3/shop/#search-for-shops
  """
  def search(client, q), do: client |> Skroutz.get("/shops/search", %{q: q})

  @doc """
  Retrieves a specific shop
  @see http://developer.skroutz.gr/api/v3/shop/#retrieve-a-single-shop
  """
  def find(client, id), do: client |> Skroutz.get("/shops/#{id}")

  @doc """
  Retrieves the reviews for a shop
  @see http://developer.skroutz.gr/api/v3/shop/#retrieve-a-shops-reviews
  """
  def reviews(client, id), do: client |> Skroutz.get("/shops/#{id}/reviews")

  @doc """
  Retrieves the locations of a shop
  @see http://developer.skroutz.gr/api/v3/shop/#list-shop-locations
  """
  def locations(client, id, params \\ %{}) do
    client |> Skroutz.get("/shops/#{id}/locations", params)
  end

  @doc """
  Retrieves a specific location for a shop
  @see http://developer.skroutz.gr/api/v3/shop/#retrieve-a-single-shop-location
  """
  def location(client, shop_id, id, params \\ %{}) do
    client |> Skroutz.get("/shops/#{shop_id}/locations/#{id}", params)
  end

  @doc """
  Performs product search for a specific shop with the provided shop_uid
  """
  def product_search(client, id, [shop_uid: shop_uid]) do
    client |> Skroutz.get("/shops/#{id}/products/search", %{shop_uid: shop_uid})
  end
end

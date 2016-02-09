defmodule Skroutz.Sku do
  @moduledoc """
  Groups functions handling [Sku](http://developer.skroutz.gr/api/v3/sku)
  endpoints
  """

  @doc """
  Retrieves a specific sku
  @see http://developer.skroutz.gr/api/v3/sku/#retrieve-a-single-sku
  """
  def find(client, id), do: client |> Skroutz.get("/skus/#{id}")

  @doc """
  Retrieves similar skus
  @see http://developer.skroutz.gr/api/v3/sku/#retrieve-similar-skus
  """
  def similar(client, id), do: client |> Skroutz.get("/skus/#{id}/similar")

  @doc """
  Retrieves products for a sku
  @see http://developer.skroutz.gr/api/v3/sku/#retrieve-an-skus-products
  """
  def products(client, sku_id), do: client |> Skroutz.get("/skus/#{sku_id}/products")

  @doc """
  Retrieves reviews for a sku
  @see http://developer.skroutz.gr/api/v3/sku/#retrieve-an-skus-reviews
  """
  def reviews(client, sku_id), do: client |> Skroutz.get("/skus/#{sku_id}/reviews")

  @doc """
  Retrieves specifications for a sku
  @see http://developer.skroutz.gr/api/v3/sku/#retrieve-an-skus-specifications
  """
  def specifications(client, sku_id) do
    client |> Skroutz.get("/skus/#{sku_id}/specifications")
  end

  @doc """
  Retrieves price history for a sku
  @see http://developer.skroutz.gr/api/v3/sku/#retrieve-a-skus-price-history
  """
  def price_history(client, sku_id) do
    client |> Skroutz.get("/skus/#{sku_id}/price_history")
  end
end

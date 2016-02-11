defmodule Skroutz.Product do
  @moduledoc """
  Groups functions handling [Product](http://developer.skroutz.gr/api/v3/product)
  endpoints
  """

  @doc """
  Retrieves a specific category
  @see http://developer.skroutz.gr/api/v3/product/#retrieve-a-single-product
  """
  def find(client, id), do: client |> Skroutz.get("/products/#{id}")
end

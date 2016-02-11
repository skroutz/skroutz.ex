defmodule Skroutz.Manufacturer do
  @moduledoc """
  Groups functions handling [Manufacturer](http://developer.skroutz.gr/api/v3/manufacturer)
  endpoints
  """

  @doc """
  Retrieves all manufacturers
  @see http://developer.skroutz.gr/api/v3/manufacturer/#list-manufacturers
  """
  def all(client), do: client |> Skroutz.get("/manufacturers")

  @doc """
  Retrieves a specific manufacturer
  @see http://developer.skroutz.gr/api/v3/manufacturer/#retrieve-a-single-manufacturer
  """
  def find(client, id), do: client |> Skroutz.get("/manufacturers/#{id}")

  @doc """
  Retrieves the categories of a manufacturer
  @see http://developer.skroutz.gr/api/v3/manufacturer/#retrieve-a-manufacturers-categories
  """
  def categories(client, id), do: client |> Skroutz.get("/manufacturers/#{id}/categories")

  @doc """
  Retrieves the skus of a manufacturer
  @see http://developer.skroutz.gr/api/v3/manufacturer/#retrieve-a-manufacturers-skus
  """
  def skus(client, id, params \\ %{}) do
    client |> Skroutz.get("/manufacturers/#{id}/skus", params)
  end
end

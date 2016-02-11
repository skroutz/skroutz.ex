defmodule Skroutz.Category do
  @moduledoc """
  Groups functions handling [Category](http://developer.skroutz.gr/api/v3/category)
  endpoints
  """

  @doc """
  Retrieves all categories
  @see http://developer.skroutz.gr/api/v3/category/#list-all-categories
  """
  def all(client), do: client |> Skroutz.get("/categories")

  @doc """
  Retrieves a specific category
  @see http://developer.skroutz.gr/api/v3/category/#retrieve-a-single-category
  """
  def find(client, id), do: client |> Skroutz.get("/categories/#{id}")

  @doc """
  Retrieves the root category
  @see http://developer.skroutz.gr/api/v3/category/#retrieve-the-root-category
  """
  def root(client), do: client |> Skroutz.get("/categories/root")

  @doc """
  Retrieves the parent of a category
  @see http://developer.skroutz.gr/api/v3/category/#retrieve-the-parent-of-a-category
  """
  def parent(client, id), do: client |> Skroutz.get("/categories/#{id}/parent")

  @doc """
  Retrieves the children of a category
  @see http://developer.skroutz.gr/api/v3/category/#list-the-children-categories-of-a-category
  """
  def children(client, id), do: client |> Skroutz.get("/categories/#{id}/children")

  @doc """
  Retrieves the manufacturers with skus in a category
  @see http://developer.skroutz.gr/api/v3/category/#list-a-categorys-manufacturers
  """
  def manufacturers(client, id, params \\ %{}) do
    client |> Skroutz.get("/categories/#{id}/manufacturers", params)
  end

  @doc """
  Retrieves the favorites in a category. Requires user authenticated access_token
  @see http://developer.skroutz.gr/api/v3/category/#list-a-categorys-favorites
  """
  def favorites(client, id) do
    client |> Skroutz.get("/categories/#{id}/favorites")
  end

  @doc """
  Retrieves the skus of a category
  @see http://developer.skroutz.gr/api/v3/sku/#list-skus-of-specific-category
  """
  def skus(client, id, params \\ %{}) do
    client |> Skroutz.get("/categories/#{id}/skus", params)
  end
end

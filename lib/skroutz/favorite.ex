defmodule Skroutz.Favorite do
  @moduledoc """
  Groups functions handling [Favorite](http://developer.skroutz.gr/api/v3/favorite)
  endpoints
  """

  @doc """
  Retrieves all favorites
  @see http://developer.skroutz.gr/api/v3/favorites/#list-favorites
  """
  def all(client), do: client |> Skroutz.get("/favorites")

  @doc """
  Retrieves a specific favorite
  @see http://developer.skroutz.gr/api/v3/favorite/#retrieve-a-single-favorite
  """
  def find(client, id), do: client |> Skroutz.get("/favorites/#{id}")

  @doc """
  Deletes a specific favorite
  @see http://developer.skroutz.gr/api/v3/favorite/#destroy-a-single-favorite
  """
  def delete(client, id) do
    client |> Skroutz.delete("/favorites/#{id}")
  end

  @doc """
  Creates a favorite
  @see http://developer.skroutz.gr/api/v3/favorites/#create-a-new-favorite
  """
  def create(client, %{sku_id: _} = options) when is_map(options) do
    client |> Skroutz.post("/favorites", Skroutz.Http.serialize_params(:favorite, options))
  end

  @doc """
  Updates a favorite
  @see http://developer.skroutz.gr/api/v3/favorites/#update-a-new-favorite
  """
  def update(client, id, options) when is_map(options) do
    client |> Skroutz.put("/favorites/#{id}", Skroutz.Http.serialize_params(:favorite, options))
  end
end

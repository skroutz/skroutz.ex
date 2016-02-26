defmodule Skroutz.FavoriteList do
  @moduledoc """
  Groups functions handling [Favorite Lists](http://developer.skroutz.gr/api/v3/favorite)
  endpoints
  """

  @doc """
  Retrieves all favorites
  @see http://developer.skroutz.gr/api/v3/favorites/#list-favorites-lists
  """
  def all(client), do: client |> Skroutz.get("/favorite_lists")

  @doc """
  Retrieves custom user favorites
  """
  def custom(client), do: client |> Skroutz.get("/favorite_lists/custom")

  @doc """
  Retrieves favorites of a specific favorite list
  @see http://developer.skroutz.gr/api/v3/favorite/#list-favorites-belonging-to-list
  """
  def favorites(client, id), do: client |> Skroutz.get("/favorite_lists/#{id}/favorites")

  @doc """
  Creates a favorite list
  @see http://developer.skroutz.gr/api/v3/favorites/#create-a-favorite-list
  """
  def create(client, %{name: _} = options) when is_map(options) do
    client |> Skroutz.post("/favorite_lists",
                           Skroutz.Http.serialize_params(:favorite_list, options))
  end

  @doc """
  Deletes a specific favorite favorite list
  @see http://developer.skroutz.gr/api/v3/favorite/#destroy-a-single-favorite_list
  """
  def delete(client, id) do
    client |> Skroutz.delete("/favorite_lists/#{id}")
  end
end

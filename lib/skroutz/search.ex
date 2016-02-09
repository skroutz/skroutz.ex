defmodule Skroutz.Search do
  @moduledoc """
  Groups functions handling [Search](http://developer.skroutz.gr/api/v3/search)
  endpoints
  """

  @doc """
  Performs search with the provided query
  @see http://developer.skroutz.gr/api/v3/search/#search
  """
  def search(client, query) do
    client |> Skroutz.get("/search", %{ q: query })
  end

  @doc """
  Performs autocomplete search with the provided query
  @see http://developer.skroutz.gr/api/v3/search/#autocomplete
  """
  def autocomplete(client, query) do
    client |> Skroutz.get("/autocomplete", %{ q: query })
  end
end

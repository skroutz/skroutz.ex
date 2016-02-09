defmodule Skroutz.SearchTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    token = "token"

    {:ok, skroutz} = Skroutz.new(token)
    {:ok, [skroutz: skroutz, search_query: "iphone 6", autocomplete_query: "iph"]}
  end

  test "search returns a Map", context do
    use_cassette "search" do
      {:ok, resource} = context[:skroutz] |> Skroutz.Search.search(context[:search_query])

      assert resource |> is_map
    end
  end

  test "autocomplete returns a Map", context do
    use_cassette "search_autocomplete" do
      {:ok, resource} = context[:skroutz]
                        |> Skroutz.Search.autocomplete(context[:autocomplete_query])

      assert resource |> is_map
    end
  end
end

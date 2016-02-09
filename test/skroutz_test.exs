defmodule SkroutzTest do
  use ExUnit.Case, async: true

  setup_all do
    client_id = "client_id"
    client_secret = "client_secret"

    {:ok, skroutz} = Skroutz.new(%{client_id: client_id, client_secret: client_secret})
    {:ok, [skroutz: skroutz, client_id: client_id, client_secret: client_secret]}
  end

  test "initialization with String, sets the token" do
    token = "token"
    {:ok, skroutz} = Skroutz.new token

    assert (skroutz |> Skroutz.token) == token
  end

  test "initialization with Map, sets the config with applied defaults", context do
    assert context[:skroutz] |> Skroutz.config == %Skroutz.Config{
      client_id: "client_id",
      client_secret: "client_secret",
      flavor: :skroutz,
      permissions: "public",
      token: nil
    }
  end

  test "flavor returns the current flavor" do
    {_, skroutz} = Skroutz.new(%{flavor: :alve})
    alve_flavor = Application.get_env(:skroutz, :flavors)[:alve]

    assert (skroutz |> Skroutz.flavor) == alve_flavor
  end
end

defmodule Skroutz.Oauth2Test do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    client_id = "client_id"
    client_secret = "client_secret"

    {:ok, skroutz} = Skroutz.new(%{client_id: client_id, client_secret: client_secret})
    {:ok, [skroutz: skroutz]}
  end

  test "issue_public_token, when credentials are valid", context do
    use_cassette "public_token_success" do
      assert (context[:skroutz] |> Skroutz.Oauth2.issue_public_token)
             == {:ok, "ACCESS_TOKEN"}
    end
  end

  test "issue_public_token, when credentials are invalid" do
    {:ok, skroutz} = Skroutz.new(%{client_id: "invalid_id",
                                     client_secret: "invalid_secret"})

    use_cassette "public_token_error" do
      assert (skroutz |> Skroutz.Oauth2.issue_public_token)
             == {:error, "Could not obtain public token"}
    end
  end
end

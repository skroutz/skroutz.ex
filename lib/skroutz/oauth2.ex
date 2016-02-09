defmodule Skroutz.Oauth2 do
  @moduledoc """
  Responsible for OAuth2.0 [authorization](http://developer.skroutz.gr/authorization)
  """

  def issue_public_token(pid) do
    import Skroutz, only: [flavor: 1]

    response = pid |> flavor
                   |> Keyword.get(:oauth_token_endpoint)
                   |> HTTPoison.post("", [], params: pid |> public_token_params)

    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: json}} ->
        {:ok, json |> parse_access_token}
      {:ok, %HTTPoison.Response{status_code: code}} when code >= 400 ->
        {:error, "Could not obtain public token"}
      {:error, _} -> {:error, "Could not obtain public token, connection error"}
    end
  end

  defp parse_access_token(json), do: json |> Poison.decode! |> Map.get("access_token")

  defp public_token_params(pid) do
    import Skroutz, only: [config: 1]

    %{
      client_id:     pid |> config |> Map.get(:client_id),
      client_secret: pid |> config |> Map.get(:client_secret),
      scope:         pid |> config |> Map.get(:permissions),
      grant_type: "client_credentials"
    }
  end
end

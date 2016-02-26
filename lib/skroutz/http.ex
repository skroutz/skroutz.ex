defmodule Skroutz.Http do
  defmacro __using__(_) do
    quote do
      @doc """
      Performs an HTTP GET request
      """
      def get(client, path, params \\ %{}), do: request(client, :get, path, params)

      @doc """
      Performs an HTTP POST request
      """
      def post(client, path, params \\ %{}), do: request(client, :post, path, params)

      @doc """
      Performs an HTTP PUT request
      """
      def put(client, path, params \\ %{}), do: request(client, :put, path, params)

      @doc """
      Performs an HTTP PATCH request
      """
      def patch(client, path, params \\ %{}), do: request(client, :patch, path, params)

      @doc """
      Performs an HTTP DELETE request
      """
      def delete(client, path, params \\ %{}), do: request(client, :delete, path, params)

      defp request(client, verb, path, params \\ %{}) do
        headers = client |> token |> build_headers

        HTTPoison.request(verb, build_path(client, path), "", headers, params: params)
        |> handle_response
      end

      defp handle_response(response) do
        case response do
          {:ok, %HTTPoison.Response{status_code: 204, body: body}}
            -> {:ok, nil}
          {:ok, %HTTPoison.Response{status_code: code, body: body}} when code in (200..399)
            -> {:ok, Poison.decode!(body)}
          {:ok, %HTTPoison.Response{status_code: code, body: body}} when code in (400..599)
            -> {:error, [code: code, body: body]}
          {:error, %HTTPoison.Error{id: _, reason: reason}} -> {:error, reason}
        end
      end
    end
  end

  @doc """
  Formats a list as query parameters for the given key

  iex> Skroutz.Http.serialize_params(:fields, [:id, :name])
  ["fields[]": :id, "fields[]": :name]
  """
  def serialize_params(k, v) when is_list(v), do: Enum.flat_map(v, &(["#{k}[]": &1]))

  @doc """
  Formats a map as query parameters for the given key

  iex> Skroutz.Http.serialize_params(:favorite, %{sku_id: 42, haveit: true})
  ["favorite[haveit]": true, "favorite[sku_id]": 42]
  """
  def serialize_params(param, m) when is_map(m) do
    m |> Enum.flat_map(fn ({k, v}) -> ["#{param}[#{k}]": v] end)
  end
end

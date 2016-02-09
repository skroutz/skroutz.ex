defmodule Skroutz do
  @type t :: pid

  alias Skroutz.Config

  @doc """
  Creates a new Skroutz process, with the provided token
  """
  def new(token) when is_bitstring(token) do
    HTTPoison.start
    Agent.start(fn -> %Config{token: token} end)
  end

  @doc """
  Creates a new Skroutz process, with the provided Skroutz.Config
  """
  def new(config = %Config{}) when is_map(config) do
    HTTPoison.start
    Agent.start(fn -> config end)
  end

  @doc """
  Creates a new Skroutz process, with the provided Map
  """
  def new(config) when is_map(config) do
    HTTPoison.start
    Agent.start(fn -> Map.merge(%Config{}, config) end)
  end

  @doc """
  Returns the current configuration of the provided process
  """
  def config(pid), do: Agent.get(pid, fn (conf) -> conf end)

  @doc """
  Returns the specified value from the current process config
  """
  def config(pid, key), do: Agent.get(pid, fn (conf) -> conf end) |> Map.get(key)

  @doc """
  Returns a memoized token or obtains one if none exists
  """
  def token(pid), do: (pid |> config(:token)) || token!(pid)

  @doc """
  Obtains a public token (client credentials)
  """
  def token!(pid) do
    case pid |> Skroutz.Oauth2.issue_public_token do
      {:ok, token} -> pid |> Agent.update(fn (conf) ->
        Map.merge(conf, %{token: token})
      end)

      token
      {:error, message} -> raise message
    end
  end

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
  Returns the flavor of the current process
  """
  def flavor(pid), do: env(:flavors)[pid |> config(:flavor)]

  defp request(client, verb, path, params \\ %{}) do
    apply(HTTPoison, verb, [build_path(client, path),
                            client |> token |> build_headers,
                            [params: params]])
    |> handle_response
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: code, body: body}} when code in (200..399)
        -> {:ok, Poison.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: code, body: body}} when code in (400..599)
        -> {:error, [code: code, body: body]}
      {:error, %HTTPoison.Error{ id: _, reason: reason }} -> {:error, reason}
    end
  end

  defp build_path(pid, path), do: (pid |> flavor)[:api_base_url] <> path

  defp build_headers(token) do
    [{"Accept", "#{env(:mimetype)}; version=#{env(:api_version)}"},
     {"Authorization", "Bearer #{token}" }]
  end

  defp env(key), do: Application.get_env(:skroutz, key)
end

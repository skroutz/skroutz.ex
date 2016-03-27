defmodule Skroutz do
  use Skroutz.Http

  @type t :: pid

  alias Skroutz.Config

  @doc """
  Creates a new Skroutz process, with the provided token
  """
  def new(token) when is_bitstring(token) do
    Agent.start(fn -> %Config{token: token} end)
  end

  @doc """
  Creates a new Skroutz process, with the provided Skroutz.Config
  """
  def new(config = %Config{}) when is_map(config) do
    Agent.start(fn -> config end)
  end

  @doc """
  Creates a new Skroutz process, with the provided Map
  """
  def new(config) when is_map(config) do
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
  Returns the flavor of the current process
  """
  def flavor(pid), do: env(:flavors)[pid |> config(:flavor)]

  defp build_path(pid, path), do: (pid |> flavor)[:api_base_url] <> path

  defp build_headers(token) do
    [{"Accept", "#{env(:mimetype)}; version=#{env(:api_version)}"},
     {"Authorization", "Bearer #{token}" }]
  end

  defp env(key), do: Application.get_env(:skroutz, key)
end

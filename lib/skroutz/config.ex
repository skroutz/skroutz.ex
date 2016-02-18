defmodule Skroutz.Config do
  @moduledoc """
  Represents a configuration belonging to a client process
  """

  @type t :: %Skroutz.Config{}
  defstruct client_id: nil,
            client_secret: nil,
            token: nil,
            flavor: :skroutz,
            permissions: "public"
end

defmodule Skroutz.Notification do
  @moduledoc """
  Groups functions handling [Notification](http://developer.skroutz.gr/api/v3/notifications)
  endpoints
  """

  @doc """
  Retrieves all notifications
  @see http://developer.skroutz.gr/api/v3/notifications/#list-notifications
  """
  def all(client), do: client |> Skroutz.get("/notifications")

  @doc """
  Retrieves a specific notification
  @see http://developer.skroutz.gr/api/v3/notifications/#retrieve-a-single-notification
  """
  def find(client, id), do: client |> Skroutz.get("/notifications/#{id}")

  @doc """
  Marks the notifications with the provided ids as viewed
  @see http://developer.skroutz.gr/api/v3/notifications/#mark-notifications-as-viewed
  """
  def view(client, ids) when is_list(ids) do
    client |> Skroutz.post("/notifications/view", Skroutz.Http.serialize_params(:ids, ids))
  end
end

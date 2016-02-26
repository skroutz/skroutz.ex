defmodule Skroutz.NotificationTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Skroutz.Notification

  setup_all do
    token = "token"

    {:ok, skroutz} = Skroutz.new(token)
    {:ok, [skroutz: skroutz, notification_id: 179498022]}
  end

  test "all returns a Map", context do
    use_cassette "notifications_all" do
      {:ok, resource} = context[:skroutz] |> Notification.all

      assert resource |> is_map
    end
  end

  test "all, notifications is a list", context do
    use_cassette "notifications_all" do
      {:ok, resource} = context[:skroutz] |> Notification.all

      assert resource |> Map.get("notifications") |> is_list
    end
  end

  test "find returns a Map", context do
    use_cassette "notifications_find" do
      {:ok, resource} = context[:skroutz]
                        |> Notification.find(context[:notification_id])

      assert resource |> is_map
    end
  end

  test "find returns the correct notification", context do
    use_cassette "notifications_find" do
      {:ok, resource} = context[:skroutz] |> Notification.find(context[:notification_id])

      assert resource |> Map.get("notification") |> Map.get("id")
             == context[:notification_id]
    end
  end

  test "view returns nil", context do
    use_cassette "notifications_view" do
      {:ok, nil} = context[:skroutz] |> Notification.view([context[:notification_id]])
    end
  end
end

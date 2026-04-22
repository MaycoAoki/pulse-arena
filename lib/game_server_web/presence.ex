defmodule GameServerWeb.Presence do
  use Phoenix.Presence, otp_app: :game_server, pubsub_server: GameServer.PubSub
end
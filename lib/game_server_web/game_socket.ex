defmodule GameServerWeb.GameSocket do
  use Phoenix.Socket

  channel "game:*", GameServerWeb.GameChannel

  def connect(%{"nickname" => nickname}, socket, _opts) when nickname != "" do
    {:ok, assign(socket, :nickname, nickname)}
  end

  def connect(_params, _socket, _opts) do
    {:error, :unauthorized}
  end

  def id(socket) do
    nickname = socket.assigns[:nickname]
    "game_socket:#{nickname}"
  end
end

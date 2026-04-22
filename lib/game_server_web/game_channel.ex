defmodule GameServerWeb.GameChannel do
  use Phoenix.Channel
  alias GameServer.GameRoom
  alias GameServer.PubSub

  @tick_interval 33  # ~30 FPS

  def join("game:" <> room_id, %{"nickname" => nickname}, socket) do
    socket = assign(socket, :room_id, room_id)
    socket = assign(socket, :nickname, nickname)
    send(self(), {:start_tick, room_id})
    {:ok, %{room_id: room_id, nickname: nickname}, socket}
  end

  def join(_room_id, _params, _socket) do
    {:error, :room_not_found}
  end

  def handle_info({:start_tick, room_id}, socket) do
    schedule_tick()
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    schedule_tick()
    broadcast_state(socket)
    {:noreply, socket}
  end

  defp schedule_tick do
    Process.send_after(self(), :tick, @tick_interval)
  end

  defp broadcast_state(socket) do
    room_id = socket.assigns.room_id
    state = %{room_id: room_id, players: %{}, timestamp: DateTime.utc_now()}
    broadcast!(socket, "state_update", state)
  end

  def handle_in("move", %{"x" => x, "y" => y}, socket) do
    nickname = socket.assigns.nickname
    broadcast!(socket, "player_moved", %{nickname: nickname, x: x, y: y})
    {:noreply, socket}
  end

  def handle_in("start_game", _params, socket) do
    room_id = socket.assigns.room_id
    broadcast!(socket, "game_started", %{room_id: room_id})
    {:noreply, socket}
  end

  def handle_in("end_game", _params, socket) do
    room_id = socket.assigns.room_id
    broadcast!(socket, "game_finished", %{room_id: room_id})
    {:noreply, socket}
  end

  def handle_in("chat_message", %{"message" => message}, socket) do
    if String.length(message) <= 500 do
      nickname = socket.assigns.nickname
      broadcast!(socket, "chat_message", %{nickname: nickname, message: message})
      {:noreply, socket}
    else
      {:reply, {:error, %{reason: "Message too long (max 500 characters)"}}, socket}
    end
  end

  def handle_in("ping", _params, socket) do
    {:reply, {:ok, %{pong: DateTime.utc_now()}}, socket}
  end
end
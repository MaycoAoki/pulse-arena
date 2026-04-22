defmodule GameServerWeb.GameSocketTest do
  use ExUnit.Case, async: true
  alias GameServerWeb.GameSocket

  describe "connect/3" do
    test "authenticates with valid nickname" do
      params = %{"nickname" => "player1"}
      socket = %Phoenix.Socket{}
      assert {:ok, socket} = GameSocket.connect(params, socket, %{})
      assert socket.assigns.nickname == "player1"
    end

    test "rejects missing nickname" do
      params = %{}
      socket = %Phoenix.Socket{}
      assert {:error, :unauthorized} = GameSocket.connect(params, socket, %{})
    end

    test "rejects empty nickname" do
      params = %{"nickname" => ""}
      socket = %Phoenix.Socket{}
      assert {:error, :unauthorized} = GameSocket.connect(params, socket, %{})
    end
  end

  describe "id/1" do
    test "generates unique identifier" do
      socket = %Phoenix.Socket{assigns: %{nickname: "player1"}}
      assert "game_socket:player1" = GameSocket.id(socket)
    end
  end
end
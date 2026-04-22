defmodule GameServer.GameRoomTest do
  use ExUnit.Case, async: true

  alias GameServer.GameRoom
  alias Game.Engine

  describe "GameRoom structure" do
    test "creates valid room state" do
      state = %{
        room_id: "room1",
        name: "Room 1",
        status: :waiting,
        players: %{},
        engine: Engine.new_game()
      }
      assert state.room_id == "room1"
      assert state.status == :waiting
    end

    test "engine works with players" do
      engine = Engine.new_game()
      {:ok, engine} = Engine.add_player(engine, "player1")
      assert "player1" in Map.keys(engine.players)
    end
  end
end
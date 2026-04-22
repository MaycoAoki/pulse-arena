defmodule Game.EngineTest do
  use ExUnit.Case, async: true

  alias Game.Engine

  describe "new_game/0" do
    test "creates a new game state" do
      assert %Engine{} = Engine.new_game()
    end
  end

  describe "add_player/2" do
    test "adds a player to the game" do
      game = Engine.new_game()
      assert {:ok, game} = Engine.add_player(game, "player1")
      assert "player1" in Map.keys(game.players)
    end

    test "returns error if player already exists" do
      game = Engine.new_game()
      {:ok, game} = Engine.add_player(game, "player1")
      assert {:error, :player_exists} = Engine.add_player(game, "player1")
    end
  end

  describe "remove_player/2" do
    test "removes a player from the game" do
      game = Engine.new_game()
      {:ok, game} = Engine.add_player(game, "player1")
      assert {:ok, game} = Engine.remove_player(game, "player1")
      refute "player1" in Map.keys(game.players)
    end
  end

  describe "validate_move/3" do
    test "validates a move within bounds" do
      game = Engine.new_game()
      {:ok, game} = Engine.add_player(game, "player1")
      assert {:ok, _game} = Engine.validate_move(game, "player1", {10, 10})
    end

    test "rejects move outside game bounds" do
      game = Engine.new_game()
      {:ok, game} = Engine.add_player(game, "player1")
      assert {:error, :out_of_bounds} = Engine.validate_move(game, "player1", {1000, 1000})
    end

    test "rejects move for non-existent player" do
      game = Engine.new_game()
      assert {:error, :player_not_found} = Engine.validate_move(game, "nonexistent", {10, 10})
    end
  end
end

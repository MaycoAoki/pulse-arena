defmodule Game.Engine do
  defstruct [:players, :board_width, :board_height]

  @board_width 100
  @board_height 100

  def new_game do
    %__MODULE__{
      players: %{},
      board_width: @board_width,
      board_height: @board_height
    }
  end

  def add_player(%__MODULE__{players: players} = game, nickname) do
    if Map.has_key?(players, nickname) do
      {:error, :player_exists}
    else
      new_players = Map.put(players, nickname, %{x: 50, y: 50, score: 0})
      {:ok, %{game | players: new_players}}
    end
  end

  def remove_player(%__MODULE__{players: players} = game, nickname) do
    new_players = Map.delete(players, nickname)
    {:ok, %{game | players: new_players}}
  end

  def move_player(%__MODULE__{players: players, board_width: w, board_height: h} = game, nickname, {x, y}) do
    player = Map.get(players, nickname)

    cond do
      is_nil(player) ->
        {:error, :player_not_found}

      x < 0 or x >= w or y < 0 or y >= h ->
        {:error, :out_of_bounds}

      true ->
        new_player = %{player | x: x, y: y}
        new_players = Map.put(players, nickname, new_player)
        {:ok, %{game | players: new_players}}
    end
  end

  def validate_position({x, y}, w, h) do
    x >= 0 and x < w and y >= 0 and y < h
  end

  def get_player(%__MODULE__{players: players}, nickname) do
    Map.get(players, nickname)
  end

  def validate_move(%__MODULE__{players: players, board_width: w, board_height: h} = game, nickname, {x, y}) do
    player = Map.get(players, nickname)

    cond do
      is_nil(player) ->
        {:error, :player_not_found}

      x < 0 or x >= w or y < 0 or y >= h ->
        {:error, :out_of_bounds}

      true ->
        {:ok, game}
    end
  end
end
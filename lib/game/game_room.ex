defmodule GameServer.GameRoom do
  use GenServer
  alias Game.Engine, as: GameEngine

  @max_players 10

  defstruct [:room_id, :name, :status, :players, :engine]

  def start_link(%{room_id: room_id, name: name}) do
    GenServer.start_link(__MODULE__, %{room_id: room_id, name: name}, name: via_tuple(room_id))
  end

  defp via_tuple(room_id) do
    {:via, Registry, {GameServer.RoomRegistry, room_id}}
  end

  def init(%{room_id: room_id, name: name}) do
    state = %__MODULE__{
      room_id: room_id,
      name: name,
      status: :waiting,
      players: %{},
      engine: GameEngine.new_game()
    }
    {:ok, state}
  end

  def state(room_id) do
    GenServer.call(via_tuple(room_id), :get_state)
  end

  def add_player(room_id, nickname) do
    GenServer.call(via_tuple(room_id), {:add_player, nickname})
  end

  def remove_player(room_id, nickname) do
    GenServer.call(via_tuple(room_id), {:remove_player, nickname})
  end

  def list_rooms do
    []
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:add_player, nickname}, _from, state) do
    cond do
      map_size(state.players) >= @max_players ->
        {:reply, {:error, :room_full}, state}

      state.status == :playing ->
        {:reply, {:error, :game_in_progress}, state}

      Map.has_key?(state.players, nickname) ->
        {:reply, {:error, :player_already_in_room}, state}

      true ->
        case GameEngine.add_player(state.engine, nickname) do
          {:ok, engine} ->
            new_players = Map.put(state.players, nickname, %{joined_at: DateTime.utc_now()})
            {:reply, :ok, %{state | players: new_players, engine: engine}}

          {:error, reason} ->
            {:reply, {:error, reason}, state}
        end
    end
  end

  def handle_call({:remove_player, nickname}, _from, state) do
    new_players = Map.delete(state.players, nickname)

    case GameEngine.remove_player(state.engine, nickname) do
      {:ok, engine} ->
        {:reply, :ok, %{state | players: new_players, engine: engine}}

      {:error, :player_not_found} ->
        {:reply, :ok, %{state | players: new_players}}
    end
  end
end

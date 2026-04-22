defmodule GameServer.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :score, :integer
    field :position, :integer
    field :finished_at, :utc_datetime
    field :player_id, :binary_id
    field :room_id, :binary_id

    timestamps()
  end

  def changeset(score, attrs) do
    score
    |> cast(attrs, [:player_id, :room_id, :score, :position, :finished_at])
    |> validate_required([:player_id, :room_id, :score])
  end
end
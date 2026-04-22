defmodule GameServer.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :player_id, :uuid
      add :room_id, :uuid
      add :score, :integer
      add :position, :integer

      timestamps(type: :utc_datetime)
    end
  end
end

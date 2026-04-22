defmodule GameServer.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :nickname, :string

      timestamps(type: :utc_datetime)
    end
  end
end

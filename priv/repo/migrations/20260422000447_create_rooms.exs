defmodule GameServer.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end

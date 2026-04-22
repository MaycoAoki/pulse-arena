defmodule GameServer.Ranking do
  import Ecto.Query
  alias GameServer.{Repo, Score, Player}

  def save_score(player_id, room_id, score, position) do
    %Score{}
    |> Score.changeset(%{
      player_id: player_id,
      room_id: room_id,
      score: score,
      position: position,
      finished_at: DateTime.utc_now()
    })
    |> Repo.insert()
  end

  def get_top_scores(limit \\ 10) do
    from(s in Score,
      join: p in Player, on: s.player_id == p.id,
      order_by: [desc: s.score],
      limit: ^limit,
      select: %{nickname: p.nickname, score: s.score, position: s.position, finished_at: s.finished_at}
    )
    |> Repo.all()
  end
end
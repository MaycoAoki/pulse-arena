defmodule GameServerWeb.RankingController do
  use GameServerWeb, :controller
  alias GameServer.Ranking

  def index(conn, _params) do
    scores = Ranking.get_top_scores(10)
    json(conn, %{scores: scores})
  end
end
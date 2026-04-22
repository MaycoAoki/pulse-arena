## ADDED Requirements

### Requirement: Score is recorded on game finish
O sistema SHALL registrar a pontuação de cada jogador ao final de uma partida.

#### Scenario: Record score on finish
- **WHEN** jogo termina (condição de vitória atingida)
- **THEN** servidor persiste no banco: `room_id`, `player_id`, `score`, `position`, `finished_at`

### Requirement: User can view ranking
O sistema SHALL permitir consultar o ranking básico.

#### Scenario: View top ranking
- **WHEN** jogador envia `{"type": "ranking"}`
- **THEN** servidor retorna `{"type": "ranking", "entries": [{"rank": 1, "player_id": "...", "score": 100}, ...]}`

### Requirement: Ranking persists across sessions
O sistema SHALL manter o ranking persistido no PostgreSQL.

#### Scenario: Ranking persists
- **WHEN** servidor é reiniciado
- **THEN** o ranking previamente registrado permanece disponível
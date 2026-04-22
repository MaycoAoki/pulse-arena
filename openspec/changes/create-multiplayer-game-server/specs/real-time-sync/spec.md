## ADDED Requirements

### Requirement: Server broadcasts state in real-time
O servidor SHALL transmitir o estado atualizado do jogo para todos os participantes da sala.

#### Scenario: State update broadcast
- **WHEN** qualquer jogador envia uma ação válida
- **THEN** servidor processa a ação, atualiza o estado da sala e faz broadcast para todos os participantes com `{"type": "state_update", "room_id": "...", "players": [...], "positions": {...}}`

### Requirement: Server sends periodic tick updates
O servidor SHALL enviar atualizações periódicas de estado mesmo sem ações do jogador (~30 FPS).

#### Scenario: Periodic tick
- **WHEN** não há ações por determinado tempo
- **THEN** servidor envia heartbeat com `{"type": "tick", "room_id": "...", "positions": {...}}`

### Requirement: Players receive notifications of game events
O servidor SHALL notificar participantes sobre eventos importantes.

#### Scenario: Game started
- **WHEN** quantidade mínima de jogadores (2) é atingida e host inicia jogo ou timer expira
- **THEN** servidor muda estado da sala para `playing` e envia `{"type": "game_started", "room_id": "..."}`

#### Scenario: Game finished
- **WHEN** condição de vitória é atingida
- **THEN** servidor muda estado para `finished`, envia `{"type": "game_finished", "room_id": "...", "winner": "<player_id>"}`
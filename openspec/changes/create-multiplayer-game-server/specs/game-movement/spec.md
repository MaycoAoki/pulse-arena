## ADDED Requirements

### Requirement: User can move in the game
O sistema SHALL validar e processar comandos de movimento enviados pelo jogador.

#### Scenario: Move in valid direction
- **WHEN** jogador envia `{"type": "action", "action": "move", "direction": "up"}`
- **THEN** servidor valida movimento (dentro dos limites do mapa), atualiza posição do jogador e faz broadcast com `{"type": "state_update", "players": {...}}`

#### Scenario: Move to invalid position
- **WHEN** jogador tenta se mover para fora dos limites do mapa
- **THEN** servidor ignora comando e não retorna erro (movimento inválido é descartado silenciosamente)

#### Scenario: Move while not in room
- **WHEN** jogador envia ação de movimento sem estar em uma sala
- **THEN** servidor rejeita com `{"type": "error", "message": "You are not in a room"}`

#### Scenario: Move while game not in playing state
- **WHEN** jogador envia ação e sala está em estado `waiting` ou `finished`
- **THEN** servidor rejeita com `{"type": "error", "message": "Game is not in progress"}`

### Requirement: Server validates movement speed
O servidor SHALL validar que jogador não envia comandos muito rápidos (rate limit).

#### Scenario: Rate limit exceeded
- **WHEN** jogador envía mais de 10 ações por segundo
- **THEN** servidor rejeita comandos excedentes com `{"type": "error", "message": "Rate limit exceeded"}`
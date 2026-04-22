## ADDED Requirements

### Requirement: User can create a room
O sistema SHALL permitir que um jogador crie uma nova sala.

#### Scenario: Create room successfully
- **WHEN** jogador autenticado envia `{"type": "create_room", "name": "Sala1"}`
- **THEN** servidor cria sala, confirma com `{"type": "room_created", "room_id": "<id>", "name": "Sala1"}` e automaticamente entra o criador na sala

### Requirement: User can list available rooms
O sistema SHALL permitir listar salas disponíveis.

#### Scenario: List rooms
- **WHEN** jogador envia `{"type": "list_rooms"}`
- **THEN** servidor retorna `{"type": "room_list", "rooms": [{"room_id": "...", "name": "...", "players_count": n}]}`

### Requirement: User can join a room
O sistema SHALL permitir que jogador entre em uma sala existente.

#### Scenario: Join room successfully
- **WHEN** jogador autenticado envia `{"type": "join_room", "room_id": "<id>"}`
- **THEN** servidor adiciona jogador à sala, confirma com `{"type": "joined_room", "room_id": "<id>"}` e faz broadcast para participantes com `{"type": "player_joined", "player_id": "<id>", "nickname": "..."}`

#### Scenario: Join non-existent room
- **WHEN** jogador tenta entrar em sala inexistente
- **THEN** servidor rejeita com `{"type": "error", "message": "Room not found"}`

#### Scenario: Room is full
- **WHEN** jogador tenta entrar em sala com 10 jogadores
- **THEN** servidor rejeita com `{"type": "error", "message": "Room is full"}`

#### Scenario: Cannot join room during game
- **WHEN** jogador tenta entrar em sala com estado `playing`
- **THEN** servidor rejeita com `{"type": "error", "message": "Cannot join room while game is in progress"}`

### Requirement: User can leave a room
O sistema SHALL permitir que jogador saia de uma sala.

#### Scenario: Leave room
- **WHEN** jogador envia `{"type": "leave_room"}`
- **THEN** servidor remove jogador da sala, confirma com `{"type": "left_room"}` e faz broadcast com `{"type": "player_left", "player_id": "<id>"}`
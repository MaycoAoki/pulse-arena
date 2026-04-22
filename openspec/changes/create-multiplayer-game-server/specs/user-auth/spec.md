## ADDED Requirements

### Requirement: User can authenticate with nickname
O sistema SHALL permitir que o usuário se autentique informando um nickname único por sala.

#### Scenario: Successful authentication
- **WHEN** cliente envia mensagem `{"type": "auth", "nickname": "Player1"}`
- **THEN** servidor atribui ID único ao jogador e confirma autenticação com `{"type": "auth_ok", "player_id": "<uuid>"}`

#### Scenario: Duplicate nickname in same room
- **WHEN** jogador tenta autenticar com nickname já usado na sala
- **THEN** servidor rejeita com `{"type": "error", "message": "Nickname already in use"}`

### Requirement: User can disconnect
O sistema SHALL detectar desconexão do WebSocket e remover jogador da sala.

#### Scenario: Client disconnects unexpectedly
- **WHEN** conexão WebSocket é fechada sem envio de `leave_room`
- **THEN** servidor remove jogador da sala e notifica demais jogadores com `{"type": "player_left", "player_id": "<id>"}`
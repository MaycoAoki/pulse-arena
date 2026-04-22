## ADDED Requirements

### Requirement: User can send chat message in room
O sistema SHALL permitir que jogadores enviem mensagens de chat dentro de uma sala.

#### Scenario: Send chat message
- **WHEN** jogador envia `{"type": "chat", "message": "Hello!"}`
- **THEN** servidor faz broadcast da mensagem para todos os participantes com `{"type": "chat_message", "player_id": "...", "nickname": "...", "message": "Hello!", "timestamp": "..."}`

#### Scenario: Send chat while not in room
- **WHEN** jogador tenta enviar chat sem estar em uma sala
- **THEN** servidor rejeita com `{"type": "error", "message": "You are not in a room"}`

#### Scenario: Chat message too long
- **WHEN** jogador tenta enviar mensagem com mais de 500 caracteres
- **THEN** servidor rejeita com `{"type": "error", "message": "Message too long (max 500 characters)"}`
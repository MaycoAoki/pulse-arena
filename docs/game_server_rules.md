# 🧠 Regras do Projeto — Servidor de Jogo Multiplayer

## 1. 🎯 Princípios do Sistema (Regras Globais)

- Servidor é a **fonte da verdade** (authoritative server)
- Cliente nunca decide estado final do jogo
- Toda ação do jogador é validada no servidor
- Estado do jogo deve ser **determinístico**
- Comunicação em tempo real via **WebSocket**
- Cada sala é **isolada** (sem estado global compartilhado)

---

## 2. 👤 Regras de Usuário

### Estrutura

- `id` (gerado no servidor)
- `nickname` (único por sala)

### Permissões

- Entrar em sala
- Sair de sala
- Enviar ações

### Restrições

- Não pode estar em mais de uma sala
- Não pode enviar ação fora de uma sala
- Nickname não pode ser duplicado na mesma sala

---

## 3. 🏠 Regras de Sala (Game Room)

### Estados

- `waiting`
- `playing`
- `finished`

### Transições

- `waiting → playing` (mínimo de jogadores atingido)
- `playing → finished` (condição de vitória)
- `finished → waiting` (reset)

### Restrições

- Mínimo de 2 jogadores para iniciar
- Não aceitar novos jogadores durante `playing` (MVP)

---

## 4. 🎮 Regras de Gameplay (MVP)

### Ações permitidas

```json
{ "action": "move", "direction": "up" }
```

### Fluxo

1. Cliente envia ação
2. Servidor valida
3. Servidor atualiza estado
4. Servidor faz broadcast

### Exemplo de resposta

```json
{
  "players": [],
  "positions": {}
}
```

### Regras

- Movimento respeita limites do mapa
- Não pode atravessar limites ou colidir (se implementado)
- Sem teleport ou velocidade inválida
- Atualização por ticks (ex: 30 FPS)

---

## 5. 🔒 Regras Anti-Cheat

- Ignorar comandos inválidos
- Rate limit por jogador (ex: 10 ações/segundo)
- Cliente envia apenas **intenção**, nunca estado
- Servidor nunca confia em dados do cliente

---

## 6. 🔄 Comunicação (WebSocket)

### Cliente → Servidor

- `join_room`
- `leave_room`
- `action`

### Servidor → Cliente

- `state_update`
- `player_joined`
- `player_left`
- `game_started`
- `game_finished`
- `error`

---

## 7. ⚙️ Regras Técnicas

### Backend

- Cada sala = 1 processo isolado
- Cada jogador = estado dentro da sala
- Uso de supervisor para tolerância a falhas
- Canal por sala: `game:<room_id>`

### Organização

- `GameRoom` → regras da sala
- `Player` → entidade
- `GameEngine` → lógica do jogo
- `Transport` → comunicação

Separação clara entre:
- transporte (WebSocket)
- regra de negócio

---

## 8. 📊 Escalabilidade

- Salas independentes
- Escala horizontal
- Uso de load balancer

### Limites iniciais

- Máx jogadores por sala: 10
- Máx salas: 100
- Latência alvo: < 100ms

---

## 9. 🧪 Testes

### Obrigatórios

- Movimento válido/inválido
- Entrada/saída de jogador

### Simulação

- 50+ jogadores simultâneos

---

## 10. 🚧 Escopo do MVP

### ❌ Não incluir

- Ranking complexo
- Login completo
- Matchmaking avançado
- Física complexa
- Microserviços

### ✅ Foco

- Multiplayer funcional
- Estado consistente
- Baixa latência
- Código limpo

---

## 11. 📌 Definition of Done

- 2–10 jogadores simultâneos funcionando
- Estado sincronizado corretamente
- Sem crashes em uso normal
- Código organizado
- README documentado

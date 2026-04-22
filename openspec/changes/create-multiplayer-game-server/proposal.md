## Why

Projetos de portfólio comuns mostram apenas CRUD ou chat básico. Este projeto resolve um problema mais interessante: como coordenar múltiplos usuários em tempo real com consistência de estado, concorrência e escalabilidade — habilidades essenciais para sistemas modernos. O momento é agora: jogos multiplayer em tempo real são uma das áreas mais valorizadas para demonstrar domínio técnico em backend.

## What Changes

- Criar servidor autoritativo multiplayer com Elixir + Phoenix
- Implementar sistema de salas com WebSocket em tempo real
- Sincronizar posição/estado entre jogadores via broadcast
- Adicionar chat simples por sala e ranking persistido
- Implementar validação de comandos do cliente

## Capabilities

### New Capabilities

- **user-auth**: Autenticação simples por nome de usuário (nickname único por sala)
- **room-management**: Criação, listagem, entrada e saída de salas
- **game-movement**: Sistema de movimento com validação no servidor
- **real-time-sync**: Broadcast de estado em tempo real via WebSocket
- **room-chat**: Chat simples dentro de cada sala
- **game-ranking**: Persistência e exibição de ranking básico

### Modified Capabilities

- *(nenhuma modificação — sistema novo)*

## Impact

- Backend: Elixir + Phoenix com Phoenix Channels
- Banco de dados: PostgreSQL para persistência de usuários, salas e ranking
- WebSocket: Comunicação em tempo real
- Deploy: Docker para empacotamento
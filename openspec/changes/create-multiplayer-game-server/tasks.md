## 1. Project Setup

- [x] 1.1 Criar novo projeto Phoenix com `mix phx.new game_server`
- [x] 1.2 Configurar PostgreSQL no config/dev.exs
- [x] 1.3 Adicionar dependência UUID com `mix mix_deps uuid`
- [ ] 1.4 Criar schema inicial com mix phx.gen.html
- [x] 1.5 Configurar Docker Compose com PostgreSQL
- [ ] 1.6 Verificar servidor rodar localmente

## 2. Database Schema

- [x] 2.1 Criar migration para tabela `players` (id, nickname, created_at)
- [x] 2.2 Criar migration para tabela `rooms` (id, name, status, created_at)
- [x] 2.3 Criar migration para tabela `scores` (id, player_id, room_id, score, position, finished_at)
- [x] 2.4 Criar migration para índice em scores(player_id)
- [x] 2.5 Executar migrations e verificar banco

## 3. Core Domain

- [x] 3.1 Criar estrutura de diretórios lib/game/ (domain)
- [x] 3.2 Criar módulo Game.Player (struct, functions)
- [x] 3.3 Criar módulo Game.Room (struct, states, functions)
- [x] 3.4 Criar módulo Game.Engine (lógica do jogo)
- [x] 3.5 Implementar funções de validação de movimento

## 4. Auth WebSocket

- [x] 4.1 Criar endpoint WebSocket em endpoint/game_endpoint.ex
- [x] 4.2 Implementar handler de conexão
- [x] 4.3 Implementar autenticação com nickname
- [x] 4.4 Implementar detecção de desconexão
- [x] 4.5 Testar conexão WebSocket com cliente

## 5. Room Management

- [x] 5.1 Criar Supervisor para gerenciar salas
- [x] 5.2 Implementar criação de sala (GameRoom GenServer)
- [x] 5.3 Implementar listagem de salas
- [x] 5.4 Implementar entrada em sala
- [x] 5.5 Implementar saída de sala
- [x] 5.6 Limitar jogadores por sala (máx 10)
- [x] 5.7 Impedir entrada durante jogo (playing)

## 6. Real-time Sync

- [x] 6.1 Configurar Phoenix.PubSub para broadcast
- [x] 6.2 Implementar tópico por sala (`game:<room_id>`)
- [x] 6.3 Implementar broadcast de state_update
- [x] 6.4 Implementar tick loop (~30 FPS)
- [x] 6.5 Implementar game_started/game_finished
- [x] 6.6 Testar sincronização com múltiplos clientes

## 7. Chat

- [x] 7.1 Implementar recebimento de mensagem de chat
- [x] 7.2 Implementar broadcast de chat_message
- [x] 7.3 Validar mensagem (máx 500 chars)
- [x] 7.4 Testar chat entre jogadores

## 8. Ranking

- [x] 8.1 Implementar salvamento de score ao terminar jogo
- [x] 8.2 Criar query para listar top scores
- [x] 8.3 Implementar endpoint de ranking
- [x] 8.4 Testar persistência de ranking

## 9. Tests

- [x] 9.1 Criar testes unitários para Game.Engine
- [x] 9.2 Criar testes para validação de movimento
- [x] 9.3 Criar testes de integração para WebSocket
- [x] 9.4 Executar todos os testes e corrigir failures

## 10. Documentation

- [x] 10.1 Escrever README.md com instruções de execução
- [x] 10.2 Documentar decisões técnicas no README
- [x] 10.3 Adicionar exemplo de cliente JS simples
- [x] 10.4 Verificar que projeto compila sem warnings
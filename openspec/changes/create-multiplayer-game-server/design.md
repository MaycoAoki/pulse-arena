## Context

Este projeto cria um servidor autoritativo para jogo multiplayer em tempo real. O servidor deve coordenar múltiplos jogadores por sala, validar todas as ações, sincronizar estado e persistir dados. stack tecnológica definida: Elixir + Phoenix (pela pesquisa comparativa), PostgreSQL e WebSocket via Phoenix Channels.

Constraints principais:
- Servidor é a fonte da verdade (authoritative)
- Cada sala é isolada (sem estado global)
- Movimentação via ticks (~30 FPS)
- Máximo 10 jogadores por sala, 100 salas disponíveis

## Goals / Non-Goals

**Goals:**
- Servidor multiplayer funcional com WebSocket
- Sistema de salas com entrada/saída
- Sincronização de estado em tempo real
- Chat por sala
- Ranking persistido com PostgreSQL
- Código testável e bem estruturado

**Non-Goals:**
- Matchmaking avançado
- Anti-cheat robusto
- Múltiplos modos de jogo
-microserviços
- Replay ou economia interna

## Decisions

### D1: Elixir + Phoenix Channels (vs Go)
**Rationale:** O modelo de concorrência da BEAM facilita lidar com muitas conexões simultâneas. Phoenix Channels oferece abstração nativa para WebSocket com suporte a canais nomeados (room-based). Alternativa considerada: Go com gorilla/websocket — exigiria mais sincronização manual e infraestrutura.

### D2: Processo isolado por sala (via Supervisor)
**Rationale:** Cada GameRoom rodando como GenServer permite isolamento de falhas. Se uma sala crashar, não afeta as outras. Alternativa considerada: processo único com map de salas — menor isolation, mas mais simples.

### D3: PostgreSQL para persistência
**Rationale:** Dados relacionais (usuários, salas, ranking) são naturalmente estruturados. Redis seria opção para cache, mas não necessário no MVP.

### D4: Broadcast via Phoenix.PubSub
**Rationale:** OPubSub do Phoenix distribui mensagens para subscribers de um tópico. Cada sala = tópico `game:<room_id>`. Alternativa considerada: direct WebSocket sends — menos escalável.

## Risks / Trade-offs

**[R1]** Concorrência em Elixir pode ser confusa para quem não conhece BEAM → Mitigação: Documentar decisões, usar testes para validar comportamento.

**[R2]** Estado determinístico requer cuidado com ordem de mensagens → Mitigação: Processar ações em sequência (single-thread per sala), não confiar em timestamps do cliente.

**[R3]** Latência em ambiente distribuído → Mitigação: Começar monolítico, escalar horizontalmente apenas após medição real.

**[R4]** WebSocket disconnects não tratadas → Mitigação: Implementar heartbeats e timeout para detectar desconexões.
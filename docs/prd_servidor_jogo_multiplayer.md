# PRD — Servidor de Jogo Multijogador

## 1. Visão geral

Este produto é um **servidor autoritativo para jogo multijogador em tempo real**, pensado como projeto de portfólio com forte sinal técnico para recrutadores e tech leads. A proposta central é demonstrar domínio de **concorrência, WebSockets, sincronização de estado, baixa latência e arquitetura escalável**.

A pesquisa comparativa recomenda manter o Projeto 1 e priorizar **Elixir com Phoenix** no backend, por causa do modelo de concorrência leve da BEAM, da facilidade para lidar com muitas conexões simultâneas e do suporte nativo a canais em tempo real.

## 2. Objetivo do produto

Construir um MVP funcional de jogo multiplayer no qual vários jogadores consigam:

- entrar em uma sala;
- enviar comandos de movimento;
- receber o estado atualizado do jogo em tempo real;
- interagir via chat simples;
- competir em um ranking básico.

O servidor deve ser o responsável por validar e distribuir o estado, sem confiar no cliente para cálculos sensíveis.

## 3. Problema que o produto resolve

Projetos de portfólio comuns costumam mostrar apenas CRUD, APIs simples ou chat básico. Este produto resolve um problema mais interessante para demonstração técnica: **como coordenar múltiplos usuários em tempo real com consistência de estado, concorrência e escalabilidade**.

Além disso, o produto serve para evidenciar habilidades úteis em sistemas modernos:

- comunicação em tempo real;
- gestão de sessões e salas;
- validação de ações do cliente;
- tolerância a falhas;
- testes concorrentes;
- monitoramento e operação.

## 4. Público-alvo

### Primário
- Recrutadores
- Tech leads
- Empresas que valorizam backend, sistemas distribuídos e aplicações em tempo real

### Secundário
- Desenvolvedores que querem estudar arquitetura multiplayer
- Portfólio pessoal para entrevistas técnicas
- Comunidade técnica interessada em concorrência e WebSockets

## 5. Proposta de valor

O produto deve comunicar claramente:

- capacidade de projetar um sistema em tempo real;
- raciocínio de backend autoritativo;
- domínio de concorrência;
- preocupação com testes e escalabilidade;
- maturidade arquitetural com separação de responsabilidades.

## 6. Recomendação técnica

### Stack principal
- **Backend:** Elixir + Phoenix
- **Persistência:** PostgreSQL
- **WebSocket / tempo real:** Phoenix Channels
- **Cache / estado efêmero opcional:** Redis
- **Testes:** ExUnit + testes de integração e carga
- **Deploy:** Docker

### Motivo da escolha
A pesquisa indica Elixir/Phoenix como melhor opção para o servidor do jogo, pois o ecossistema facilita lidar com muitas conexões concorrentes e com isolamento de processos. Go continua sendo uma alternativa válida, mas exigiria mais sincronização manual e maior esforço de infraestrutura para o mesmo resultado.

## 7. Objetivos do MVP

O MVP precisa entregar apenas o essencial:

1. autenticação simples por nome de usuário;
2. criação e entrada em sala;
3. sincronização de posição/estado em tempo real;
4. broadcast do estado para todos os participantes da sala;
5. chat simples dentro da partida;
6. ranking básico persistido;
7. validação mínima contra comandos inválidos.

## 8. Escopo funcional

### 8.1 Funcionalidades incluídas
- Cadastro/login simplificado;
- criação e listagem de salas;
- entrada e saída de sala;
- envio de eventos de movimento;
- atualização de estado em tempo real;
- chat da sala;
- persistência de pontuação;
- leaderboard básico;
- monitoramento simples de saúde do serviço;
- testes unitários e de integração.

### 8.2 Fora do escopo inicial
- matchmaking avançado;
- anti-cheat robusto;
- múltiplos modos de jogo;
- loja virtual;
- inventário;
- sistema social completo;
- chat privado;
- replay;
- economia interna complexa;
- ranking global avançado.

## 9. Personas e jornadas

### Persona 1 — Jogador
Quer entrar rápido em uma sala, jogar e ver feedback imediato das ações.

**Jornada:**
1. acessa o sistema;
2. informa nome de usuário;
3. entra em uma sala disponível;
4. envia comandos de movimento;
5. vê o estado sincronizado em tempo real;
6. interage no chat;
7. recebe pontuação ao final.

### Persona 2 — Admin / Operador
Quer acompanhar estabilidade, uso e saúde do serviço.

**Jornada:**
1. verifica logs e métricas;
2. monitora número de conexões;
3. acompanha latência;
4. identifica falhas ou gargalos;
5. ajusta capacidade conforme demanda.

### Persona 3 — Recrutador / Tech lead
Quer avaliar profundidade técnica do projeto.

**Jornada:**
1. lê a documentação;
2. entende a arquitetura;
3. observa testes e decisões técnicas;
4. avalia concisão do MVP;
5. identifica maturidade em concorrência e escalabilidade.

## 10. Requisitos funcionais

### RF-01 — Autenticação simples
O sistema deve permitir que o usuário entre informando um identificador único.

### RF-02 — Gerenciamento de salas
O sistema deve permitir criar, listar, entrar e sair de salas.

### RF-03 — Comunicação em tempo real
O sistema deve receber eventos do cliente e transmitir o estado atualizado aos demais jogadores da sala.

### RF-04 — Estado autoritativo
O servidor deve ser a fonte da verdade para posição, pontuação e demais regras sensíveis.

### RF-05 — Chat em sala
Os jogadores devem conseguir enviar mensagens para os participantes da mesma sala.

### RF-06 — Ranking
O sistema deve registrar pontuação e exibir um ranking básico.

### RF-07 — Validação de comandos
O servidor deve rejeitar eventos inválidos, impossíveis ou fora da regra.

### RF-08 — Observabilidade básica
O sistema deve expor logs e indicadores suficientes para diagnóstico inicial.

## 11. Requisitos não funcionais

### RNF-01 — Baixa latência
As interações em tempo real devem ter resposta rápida o suficiente para uma experiência fluida.

### RNF-02 — Escalabilidade horizontal
O sistema deve ser capaz de crescer com múltiplas instâncias quando necessário.

### RNF-03 — Resiliência
Falhas pontuais não devem derrubar o serviço inteiro.

### RNF-04 — Segurança básica
O sistema não deve confiar no cliente para cálculos críticos.

### RNF-05 — Testabilidade
O código deve ser organizado para testes unitários, integração e carga.

### RNF-06 — Manutenibilidade
A arquitetura deve favorecer desacoplamento, clareza e evolução incremental.

## 12. Arquitetura de alto nível

### Componentes principais
- Gateway WebSocket
- Gerenciador de salas
- Motor de regras do jogo
- Serviço de pontuação
- Persistência
- Telemetria/logs

### Fluxo principal
1. o cliente conecta via WebSocket;
2. autentica com nome de usuário;
3. entra em uma sala;
4. envia comandos;
5. o servidor valida o comando;
6. o estado da sala é atualizado;
7. o novo estado é transmitido para todos;
8. a pontuação é registrada quando aplicável.

## 13. Métricas de sucesso

### Produto
- tempo médio de resposta aceitável nas ações do jogo;
- sincronização estável entre clientes;
- número de conexões simultâneas suportadas no MVP;
- taxa de erro baixa;
- estabilidade durante testes de carga.

### Portfólio
- documentação clara;
- arquitetura bem explicada;
- testes cobrindo regras centrais;
- README com decisões técnicas;
- demonstração de concorrência e tempo real.

## 14. Critérios de aceite

O MVP será considerado pronto quando:

- um usuário conseguir entrar e jogar em uma sala;
- o servidor atualizar e distribuir estado em tempo real;
- o chat funcionar dentro da sala;
- o ranking básico estiver salvo no banco;
- comandos inválidos forem recusados;
- houver testes cobrindo o core;
- o projeto estiver documentado para execução local.

## 15. Riscos e mitigação

### Risco 1 — Cheating / manipulação do cliente
**Mitigação:** servidor autoritativo, validação de comando e rejeição de ações impossíveis.

### Risco 2 — Bugs de concorrência
**Mitigação:** testes concorrentes, isolamento de processos e revisão cuidadosa do estado compartilhado.

### Risco 3 — Escopo crescer demais
**Mitigação:** manter o MVP pequeno e priorizar somente o core.

### Risco 4 — Curva de aprendizado de Elixir
**Mitigação:** começar com Phoenix, Channels e GenServer antes de adicionar features avançadas.

### Risco 5 — Sobrecarga de infraestrutura
**Mitigação:** começar com uma instância simples e evoluir apenas após medição real.

## 16. Roadmap

### Fase 1 — MVP core
- setup do projeto;
- auth simples;
- canais WebSocket;
- salas;
- movimentação;
- estado sincronizado.

### Fase 2 — Features de valor
- chat;
- ranking;
- persistência de usuários e partidas;
- métricas básicas.

### Fase 3 — Polimento
- testes;
- documentação;
- ajustes de performance;
- observabilidade;
- preparação para demo pública.

## 17. Fora da fase inicial

Essas ideias ficam para futuras versões:
- matchmaking inteligente;
- modos de jogo alternativos;
- anti-cheat avançado;
- torneios;
- histórico de partidas;
- replay;
- ranking global refinado.

## 18. Definição de pronto

O produto estará “pronto o suficiente” para portfólio quando:
- for possível demonstrar uma partida ao vivo;
- houver consistência clara de estado;
- a documentação explicar as escolhas técnicas;
- os testes mostrarem preocupação com qualidade;
- a arquitetura evidenciar domínio de concorrência e tempo real.

## 19. Conclusão

A melhor leitura desta pesquisa é: **manter o projeto do jogo e construí-lo como um servidor multiplayer autoritativo, preferencialmente com Elixir/Phoenix**. Essa decisão maximiza o valor de portfólio, evidencia domínio técnico em concorrência e mantém o escopo realista para um MVP forte.


# Docker Development Environment

## Quick Commands

```bash
# Build and start containers
docker compose up -d --build

# Start existing containers
docker compose up -d

# Stop containers
docker compose down

# View logs
docker compose logs -f app

# Access container shell
docker compose exec app bash
```

## Accessing Services

| Service | URL/Host | Credentials |
|---------|----------|-------------|
| Phoenix | http://localhost:4000 | - |
| Database | localhost:5432 | postgres / postgres |
| Redis | localhost:6379 | - |

## Environment Variables

Copie `.env.docker` para `.env` e configure:

```bash
cp .env.docker .env
# Edite com suas chaves
```

Gere uma SECRET_KEY_BASE:
```bash
mix phx.gen.secret
```

## Phoenix Specific Commands

```bash
# Run migrations
docker compose exec app mix ecto.migrate

# Create migration
docker compose exec app mix ecto.gen.migration create_table

# Access IEx
docker compose exec app iex -S mix

# Run tests
docker compose exec app mix test
```

## Troubleshooting

### Database connection failed
```bash
# Check if database is ready
docker compose logs db

# Try reconnecting
docker compose restart app
```

### Redis connection failed
```bash
# Check Redis logs
docker compose logs redis
```

### Rebuild everything
```bash
docker compose down -v
docker compose up -d --build
```
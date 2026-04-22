.PHONY: help build up down restart logs clean test ps secret

help:
	@echo "Phoenix Docker Development Commands"
	@echo "===================================="
	@echo "make build       - Build and start containers"
	@echo "make up          - Start existing containers"
	@echo "make down        - Stop containers"
	@echo "make restart     - Restart containers"
	@echo "make logs        - View app logs (follow)"
	@echo "make ps          - Show running containers"
	@echo "make clean       - Stop and remove volumes"
	@echo "make test        - Run tests in container"
	@echo "make secret      - Generate new SECRET_KEY_BASE"
	@echo "make migrate     - Run ecto migrations"
	@echo "make shell       - Access container shell"
	@echo "make health      - Run health check"

build:
	docker compose up -d --build

up:
	docker compose up -d

down:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs -f app

ps:
	docker compose ps

clean:
	docker compose down -v

test:
	docker compose exec app mix test

secret:
	@echo "Generated secret:"
	@docker compose run --rm app mix phx.gen.secret

migrate:
	docker compose exec app mix ecto.migrate

shell:
	docker compose exec app /bin/bash

health:
	@bash scripts/health-check.sh

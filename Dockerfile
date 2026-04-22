FROM elixir:1.14-alpine AS builder

RUN apk add --no-cache build-base nodejs npm git

WORKDIR /app

COPY mix.exs mix.lock ./
RUN mix local.hex --force && mix local.rebar --force && mix deps.get

COPY priv priv
COPY lib lib
COPY config config

RUN mix phx.digest

FROM elixir:1.14-alpine AS runtime

RUN apk add --no-cache postgresql-client

WORKDIR /app

COPY --from=builder /app/deps deps
COPY --from=builder /app/_build build
COPY --from=builder /app/priv priv
COPY . .

RUN mix local.hex --force && mix local.rebar --force

EXPOSE 4000

ENV DB_HOST=db

CMD ["mix", "phx.server"]
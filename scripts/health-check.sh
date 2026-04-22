#!/bin/bash
set -e

echo "Docker Local Dev - Health Check"
echo "================================"
echo ""

check_service() {
    local name=$1
    local cmd=$2
    echo -n "Checking $name............"
    if eval "$cmd" > /dev/null 2>&1; then
        echo " OK"
        return 0
    else
        echo " FAILED"
        return 1
    fi
}

echo "Checking Postgres............"
docker compose exec -T db pg_isready -U postgres && echo " OK" || echo " FAILED"

echo "Checking Redis..............."
docker compose exec -T redis redis-cli ping && echo " OK" || echo " FAILED"

echo "Checking Phoenix............"
curl -s -o /dev/null -w "%{http_code}" http://localhost:4000 || echo "FAILED (may need build)"

echo ""
echo "All services checked!"
echo ""
echo "Your development environment:"
echo "- Phoenix: http://localhost:4000"
echo "- Database: localhost:5432 (user: postgres, pass: postgres)"
echo "- Redis: localhost:6379"
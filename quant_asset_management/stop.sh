#!/bin/bash

# Minseo Asset Management Portal - Stop Script (macOS)

echo "Stopping Minseo Asset Management Portal..."
echo ""

# Stop and remove all containers
echo "Stopping containers..."
if command -v docker-compose &> /dev/null; then
    docker-compose down --remove-orphans 2>/dev/null || true
else
    docker compose down --remove-orphans 2>/dev/null || true
fi

# Remove any dangling containers that might be holding ports
echo "Cleaning up orphaned containers..."
docker container prune -f 2>/dev/null || true

# Remove networks that might be causing issues
echo "Cleaning up networks..."
docker network prune -f 2>/dev/null || true

# Check and kill any process using ports 8000, 5173, 3306
echo ""
echo "Checking for processes using our ports..."
for port in 8000 5173 3306; do
    pid=$(lsof -ti :$port 2>/dev/null || true)
    if [ -n "$pid" ]; then
        echo "Found process $pid using port $port. Killing..."
        kill -9 $pid 2>/dev/null || true
        echo "  ✓ Killed process $pid"
    else
        echo "  ✓ Port $port is free"
    fi
done

echo ""
echo "=========================================="
echo "Services stopped and cleaned!"
echo "=========================================="
echo ""
echo "To completely remove everything, run: ./uninstall.sh"

#!/bin/bash

# Minseo Asset Management Portal - Logs Script (macOS)

echo "Showing logs for Minseo Asset Management Portal..."
echo "Press Ctrl+C to exit"

if command -v docker-compose &> /dev/null; then
    docker-compose logs -f
elif command -v docker &> /dev/null; then
    docker compose logs -f
fi

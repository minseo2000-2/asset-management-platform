#!/bin/bash

# Minseo Asset Management Portal - Uninstall Script (macOS)

set -e

echo "=========================================="
echo "Uninstalling Minseo Asset Management Portal"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}This will:${NC}"
echo "  1. Stop all Docker containers"
echo "  2. Remove Docker volumes (database data)"
echo "  3. Remove Python virtual environment"
echo "  4. Remove Node modules"
echo ""

read -p "Are you sure you want to continue? (yes/no): " confirmation

if [ "$confirmation" != "yes" ]; then
    echo "Uninstall cancelled."
    exit 0
fi

echo ""
echo "Stopping Docker services..."
if command -v docker-compose &> /dev/null; then
    docker-compose down -v
elif command -v docker &> /dev/null; then
    docker compose down -v
fi

echo "Removing Docker images..."
docker rmi minseo_backend minseo_frontend 2>/dev/null || true

echo ""
echo "Removing Python virtual environment..."
if [ -d "venv" ]; then
    rm -rf venv
    echo "  • Removed venv/"
fi

echo "Removing Node modules..."
if [ -d "src/vue/node_modules" ]; then
    rm -rf src/vue/node_modules
    echo "  • Removed src/vue/node_modules/"
fi

echo "Removing Node packages..."
if [ -d "src/vue/node_modules" ]; then
    rm -rf src/vue/node_modules
fi

echo ""
echo -e "${GREEN}Uninstall complete!${NC}"
echo ""
echo "Manual cleanup (optional):"
echo "  rm -rf venv"
echo "  rm -rf src/vue/node_modules"
echo "  rm -rf src/vue/dist"
echo "  brew uninstall docker-compose  # if installed via brew"
echo "  brew uninstall --cask docker   # if installed via brew"
echo ""

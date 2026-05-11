#!/bin/bash

# Complete Cleanup Script - Minseo Asset Management Portal
# This will remove ALL minseo-related systems

echo "=========================================="
echo "Complete Cleanup - Minseo Asset Management"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ==========================================
# Step 1: Stop and remove Docker containers
# ==========================================
echo -e "${YELLOW}[1/5] Stopping Docker containers...${NC}"

if command -v docker-compose &> /dev/null; then
    docker-compose down -v --remove-orphans 2>/dev/null || true
elif command -v docker &> /dev/null; then
    docker compose down -v --remove-orphans 2>/dev/null || true
fi

# Remove all containers (including non-minseo)
docker container prune -f 2>/dev/null || true

echo -e "${GREEN}  Done${NC}"
echo ""

# ==========================================
# Step 2: Remove Docker images
# ==========================================
echo -e "${YELLOW}[2/5] Removing Docker images...${NC}"

if command -v docker-compose &> /dev/null; then
    docker-compose images -q 2>/dev/null | xargs -r docker rmi -f 2>/dev/null || true
fi

# Remove minseo-related images
docker rmi minseo_backend minseo_frontend 2>/dev/null || true
docker rmi minseo/mysql minseo/backend minseo/frontend 2>/dev/null || true

# Clean up dangling images
docker image prune -f 2>/dev/null || true

echo -e "${GREEN}  Done${NC}"
echo ""

# ==========================================
# Step 3: Remove Docker volumes
# ==========================================
echo -e "${YELLOW}[3/5] Removing Docker volumes...${NC}"

# Remove minseo volumes
if [ -n "$(docker volume ls -q -f name=minseo 2>/dev/null)" ]; then
    docker volume rm $(docker volume ls -q -f name=minseo 2>/dev/null) 2>/dev/null || true
fi

# Also try with compose prefix
if [ -n "$(docker volume ls -q -f name=asset_management 2>/dev/null)" ]; then
    docker volume rm $(docker volume ls -q -f name=asset_management 2>/dev/null) 2>/dev/null || true
fi

# Remove all unused volumes
docker volume prune -f 2>/dev/null || true

echo -e "${GREEN}  Done${NC}"
echo ""

# ==========================================
# Step 4: Remove Python virtual environment
# ==========================================
echo -e "${YELLOW}[4/5] Removing Python virtual environment...${NC}"

if [ -d "venv" ]; then
    rm -rf venv
    echo -e "  ${GREEN}Removed venv/${NC}"
else
    echo -e "  ${GREEN}venv/ not found${NC}"
fi

echo -e "${GREEN}  Done${NC}"
echo ""

# ==========================================
# Step 5: Remove Node modules and build artifacts
# ==========================================
echo -e "${YELLOW}[5/5] Removing Node modules and build artifacts...${NC}"

if [ -d "src/vue/node_modules" ]; then
    rm -rf src/vue/node_modules
    echo -e "  ${GREEN}Removed src/vue/node_modules/${NC}"
else
    echo -e "  ${GREEN}src/vue/node_modules/ not found${NC}"
fi

if [ -d "src/vue/dist" ]; then
    rm -rf src/vue/dist
    echo -e "  ${GREEN}Removed src/vue/dist/${NC}"
else
    echo -e "  ${GREEN}src/vue/dist/ not found${NC}"
fi

echo -e "${GREEN}  Done${NC}"
echo ""

# ==========================================
# Cleanup networks
# ==========================================
echo -e "${YELLOW}Cleaning up Docker networks...${NC}"
docker network prune -f 2>/dev/null || true
echo -e "${GREEN}  Done${NC}"
echo ""

echo "=========================================="
echo -e "${GREEN}Complete Cleanup Finished!${NC}"
echo "=========================================="
echo ""
echo "The following may need manual cleanup (optional):"
echo "  rm -rf venv"
echo "  rm -rf src/vue/node_modules"
echo "  rm -rf src/vue/dist"
echo "  brew uninstall docker-compose  # if installed via brew"
echo "  brew uninstall --cask docker   # if installed via brew"
echo ""

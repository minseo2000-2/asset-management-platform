#!/bin/bash

# Minseo Asset Management Portal - Conflict Resolution Script (macOS)

echo "=========================================="
echo "Fixing Docker Installation Conflicts"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Find and list conflicting binaries
echo "Checking for conflicting binaries in /usr/local/bin/..."
echo ""

conflicts_found=0

if [ -f "/usr/local/bin/docker" ]; then
    echo -e "${YELLOW}Found: /usr/local/bin/docker${NC}"
    conflicts_found=1
fi

if [ -f "/usr/local/bin/hub-tool" ]; then
    echo -e "${YELLOW}Found: /usr/local/bin/hub-tool${NC}"
    conflicts_found=1
fi

if [ -f "/usr/local/bin/docker-compose" ]; then
    echo -e "${YELLOW}Found: /usr/local/bin/docker-compose${NC}"
    conflicts_found=1
fi

echo ""

if [ $conflicts_found -eq 0 ]; then
    echo -e "${GREEN}No conflicting binaries found!${NC}"
    echo "You can proceed with ./start.sh"
    exit 0
fi

echo "----------------------------------------"
echo ""

read -p "Would you like to remove these conflicting binaries? (yes/no): " remove_conflicts

if [ "$remove_conflicts" != "yes" ]; then
    echo "Cancelled."
    exit 0
fi

echo ""
echo "Removing conflicting binaries..."

# Remove each conflicting file
for binary in docker hub-tool docker-compose; do
    if [ -f "/usr/local/bin/$binary" ]; then
        if sudo rm -f "/usr/local/bin/$binary" 2>/dev/null; then
            echo -e "${GREEN}✓ Removed /usr/local/bin/$binary${NC}"
        else
            echo -e "${RED}✗ Failed to remove /usr/local/bin/$binary${NC}"
        fi
    fi
done

echo ""
echo "Checking for conflicting npm packages..."

# Check for global docker-related npm packages
if command -v npm &> /dev/null; then
    global_pkgs=$(npm list -g 2>/dev/null | grep -E "docker|hub-tool" || true)
    if [ -n "$global_pkgs" ]; then
        echo -e "${YELLOW}Found global npm packages:${NC}"
        echo "$global_pkgs"
        read -p "Remove these global npm packages? (yes/no): " remove_npm
        if [ "$remove_npm" == "yes" ]; then
            npm uninstall -g docker-cli hub-tool 2>/dev/null || true
            echo "Removed npm packages."
        fi
    else
        echo -e "${GREEN}No conflicting npm packages found.${NC}"
    fi
fi

echo ""
echo "=========================================="
echo -e "${GREEN}Conflict resolution complete!${NC}"
echo "=========================================="
echo ""
echo "Now you can run ./start.sh again."
echo ""

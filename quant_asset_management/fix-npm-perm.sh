#!/bin/bash

# Fix npm cache permissions on macOS
# Run this if you get EACCES errors during npm install

echo "=========================================="
echo "Fixing npm cache permissions"
echo "=========================================="
echo ""

# Check if npm cache exists
if [ ! -d "/Users/parkminseo/.npm" ] && [ ! -d "$HOME/.npm" ]; then
    echo "No npm cache found. Nothing to fix."
    exit 0
fi

# Determine which home directory to use
if [ -d "/Users/parkminseo/.npm" ]; then
    NPM_DIR="/Users/parkminseo/.npm"
elif [ -d "$HOME/.npm" ]; then
    NPM_DIR="$HOME/.npm"
else
    echo "No npm cache found. Nothing to fix."
    exit 0
fi

echo "Found npm cache at: $NPM_DIR"
echo ""

# Fix ownership
echo "Fixing ownership..."
if sudo chown -R $(whoami) "$NPM_DIR" 2>/dev/null; then
    echo -e "\033[0;32m✓ Successfully fixed npm cache permissions!\033[0m"
    echo ""
    echo "You can now run npm install without errors."
else
    echo -e "\033[0;31m✗ Failed to fix permissions. Try running manually:\033[0m"
    echo "  sudo chown -R $(whoami) $NPM_DIR"
    exit 1
fi

# Also fix the specific cache directory if it exists
if [ -d "$NPM_DIR/_cacache" ]; then
    echo ""
    echo "Cleaning npm cache..."
    npm cache clean --force 2>/dev/null || echo "Cache cleaned (or npm not available)"
fi

echo ""
echo "=========================================="
echo -e "\033[0;32mDone!\033[0m"
echo "=========================================="

#!/bin/bash

# Cleanup hub-tool conflict for Docker Desktop installation
# This script removes the conflicting hub-tool binary

echo "=========================================="
echo "Cleaning up hub-tool conflict"
echo "=========================================="
echo ""

# Function to remove file with sudo if needed
remove_file() {
    local file=$1
    local description=$2

    if [ ! -f "$file" ]; then
        return 0
    fi

    echo "Found $description at $file"

    # Try with sudo first
    if sudo rm -f "$file" 2>/dev/null; then
        echo "  ✓ Removed (with sudo)"
        return 0
    fi

    # Try without sudo
    if rm -f "$file" 2>/dev/null; then
        echo "  ✓ Removed (without sudo)"
        return 0
    fi

    echo "  ✗ Could not remove. You may need to do this manually:"
    echo "      sudo rm -f $file"
    return 1
}

conflicts_removed=0

# Check and remove hub-tool
if remove_file "/usr/local/bin/hub-tool" "hub-tool binary"; then
    conflicts_removed=$((conflicts_removed + 1))
fi

# Check and remove docker binary (if it's from homebrew, not Docker Desktop)
if remove_file "/usr/local/bin/docker" "docker binary"; then
    conflicts_removed=$((conflicts_removed + 1))
fi

# Check for docker in /usr/bin (legacy location)
if remove_file "/usr/bin/docker" "docker binary"; then
    conflicts_removed=$((conflicts_removed + 1))
fi

echo ""
echo "=========================================="

if [ $conflicts_removed -gt 0 ]; then
    echo -e "\033[0;32mRemoved $conflicts_removed conflicting binary(ies)!\033[0m"
    echo "You can now run ./start.sh again."
else
    echo -e "\033[0;32mNo conflicting binaries found.\033[0m"
fi

echo "=========================================="

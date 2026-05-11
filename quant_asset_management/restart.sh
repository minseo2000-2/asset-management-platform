#!/bin/bash

# Minseo Asset Management Portal - Restart Script (macOS)

set -e

echo "Restarting Minseo Asset Management Portal..."

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please run ./start.sh first to install Docker."
    exit 1
fi

# Stop services
echo "Stopping existing services..."
if command -v docker-compose &> /dev/null; then
    docker-compose down 2>/dev/null || true
else
    docker compose down 2>/dev/null || true
fi

# Start services
echo "Starting services..."
if command -v docker-compose &> /dev/null; then
    docker-compose up -d --build
else
    docker compose up -d --build
fi

echo ""
echo "Services restarted successfully!"
echo ""
echo "Access the application:"
echo "  Frontend: http://localhost:5173"
echo "  Backend API: http://localhost:8000"
echo "  API Docs: http://localhost:8000/docs"

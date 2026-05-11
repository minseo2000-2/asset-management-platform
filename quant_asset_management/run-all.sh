#!/bin/bash

# Minseo Asset Management Portal - Full Integration Run Script (macOS)
# Docker Compose로 전체 프로젝트 통합 실행

set -e

echo "=========================================="
echo "Minseo Asset Management Portal"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ $2${NC}"
    else
        echo -e "${RED}✗ $2${NC}"
    fi
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# ==========================================
# Prerequisites Check
# ==========================================
echo ""
echo "[Check] Checking prerequisites..."
echo ""

if ! command -v docker &> /dev/null; then
    print_warning "Docker is not installed."
    print_info "Please install Docker Desktop first: https://www.docker.com/products/docker-desktop"
    exit 1
fi

print_status 0 "Docker command found"

if ! docker info &> /dev/null 2>&1; then
    print_warning "Docker daemon is not running."
    print_info "Please start Docker Desktop first."
    exit 1
fi

print_status 0 "Docker is running"

# Check for docker-compose (legacy) or docker compose (plugin)
COMPOSE_CMD=""
if command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
    print_status 0 "Docker Compose (legacy) found"
elif docker compose version &> /dev/null 2>&1; then
    COMPOSE_CMD="docker compose"
    print_status 0 "Docker Compose (plugin) found"
else
    print_warning "Docker Compose not found properly."
    print_info "Trying 'docker compose' anyway..."
    COMPOSE_CMD="docker compose"
fi

# ==========================================
# Stop existing services
# ==========================================
echo ""
echo "[Stop] Stopping existing services..."
echo ""

$COMPOSE_CMD down --remove-orphans 2>/dev/null || true

# Clean up any stopped containers
docker container prune -f 2>/dev/null || true

# ==========================================
# Check and kill processes using our ports
# ==========================================
echo ""
echo "[Port Check] Checking for processes using our ports..."
echo ""

for port in 3306 8000 5173; do
    pid=$(lsof -ti :$port 2>/dev/null || true)
    if [ -n "$pid" ]; then
        print_warning "Found process $pid using port $port. Killing..."
        kill -9 $pid 2>/dev/null || true
        print_status 0 "Killed process on port $port"
    else
        print_status 0 "Port $port is free"
    fi
done

# ==========================================
# Start all services
# ==========================================
echo ""
echo "[Start] Starting all services..."
echo ""

print_info "Services to start:"
print_info "  • MySQL Database (port 3306)"
print_info "  • FastAPI Backend (port 8000)"
print_info "  • Vue.js Frontend (port 5173)"
echo ""

# Build and start
if [ "$COMPOSE_CMD" == "docker-compose" ]; then
    docker-compose up -d --build
else
    docker compose up -d --build
fi

print_status 0 "Services started"

# ==========================================
# Wait for services to be ready
# ==========================================
echo ""
echo "[Wait] Waiting for services to initialize..."
echo ""

# Wait for MySQL
print_info "Waiting for MySQL..."
countdown=30
while [ $countdown -gt 0 ]; do
    if docker exec -i minseo_db mysqladmin -u minseo_user -pminseo_pass123 ping &>/dev/null 2>&1; then
        print_status 0 "MySQL is ready"
        break
    fi
    sleep 1
    countdown=$((countdown - 1))
    printf "."
done
echo ""

# Wait for Backend
print_info "Waiting for Backend API..."
countdown=15
while [ $countdown -gt 0 ]; do
    if curl -s http://localhost:8000/docs &>/dev/null; then
        print_status 0 "Backend API is ready"
        break
    fi
    sleep 1
    countdown=$((countdown - 1))
    printf "."
done
echo ""

# Wait for Frontend
print_info "Waiting for Frontend..."
countdown=10
while [ $countdown -gt 0 ]; do
    if curl -s http://localhost:5173 &>/dev/null; then
        print_status 0 "Frontend is ready"
        break
    fi
    sleep 1
    countdown=$((countdown - 1))
    printf "."
done
echo ""

# ==========================================
# Show status
# ==========================================
echo ""
echo "=========================================="
echo -e "${GREEN}All Services Started!${NC}"
echo "=========================================="
echo ""
echo "Access the application:"
echo "  • Frontend:   http://localhost:5173"
echo "  • Backend:    http://localhost:8000"
echo "  • API Docs:   http://localhost:8000/docs"
echo ""
echo "Database: MySQL"
echo "  • Host:       localhost:3306"
echo "  • Database:   minseo_asset"
echo "  • User:       minseo_user"
echo "  • Password:   minseo_pass123"
echo ""
echo "Useful commands:"
echo "  • ./stop.sh       - Stop all services"
echo "  • ./restart.sh    - Restart Docker services only"
echo "  • ./reboot.sh     - Restart all services (Docker + local)"
echo "  • ./logs.sh       - View logs"
echo ""
echo "Docker commands:"
echo "  • docker ps       - Show running containers"
echo "  • docker logs -f db     - View MySQL logs"
echo "  • docker logs -f backend - View Backend logs"
echo "  • docker logs -f frontend - View Frontend logs"
echo ""

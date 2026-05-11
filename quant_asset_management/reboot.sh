#!/bin/bash

# Minseo Asset Management Portal - Full Reboot Script (macOS)
# Docker services + Backend + Frontend 모두 재시작

set -e

echo "=========================================="
echo "Minseo Asset Management Portal - Full Reboot"
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
# Step 1: Stop all services
# ==========================================
echo ""
echo "[1/3] Stopping all services..."
echo ""

# Stop Docker services
if command -v docker-compose &> /dev/null; then
    docker-compose down --remove-orphans 2>/dev/null || true
elif command -v docker &> /dev/null; then
    docker compose down --remove-orphans 2>/dev/null || true
fi

# Kill any existing Python/FastAPI processes
print_info "Stopping backend processes..."
pkill -f "uvicorn main:app" 2>/dev/null || true
pkill -f "python.*main.py" 2>/dev/null || true

# Kill any existing Node/Vue processes
print_info "Stopping frontend processes..."
pkill -f "vite" 2>/dev/null || true
pkill -f "node.*src/vue" 2>/dev/null || true

# Clean up orphaned containers
docker container prune -f 2>/dev/null || true
docker network prune -f 2>/dev/null || true

echo ""
print_status 0 "All services stopped"

# ==========================================
# Step 2: Start Docker services
# ==========================================
echo ""
echo "[2/3] Starting Docker services (MySQL)..."
echo ""

# Kill processes using ports before starting Docker
for port in 3306; do
    pid=$(lsof -ti :$port 2>/dev/null || true)
    if [ -n "$pid" ]; then
        kill -9 $pid 2>/dev/null || true
    fi
done

if command -v docker-compose &> /dev/null; then
    docker-compose up -d
elif command -v docker &> /dev/null; then
    docker compose up -d
fi

# Wait for MySQL to be ready
print_info "Waiting for MySQL to be ready..."
countdown=30
while [ $countdown -gt 0 ]; do
    if docker exec -i $(docker ps -q -f name=minseo-db 2>/dev/null) mysqladmin -u minseo_user -pminseo_pass123 ping &>/dev/null 2>&1; then
        print_status 0 "MySQL is ready"
        break
    fi
    sleep 1
    countdown=$((countdown - 1))
    printf "."
done
echo ""

# ==========================================
# Step 3: Start Backend (FastAPI)
# ==========================================
echo ""
echo "[3/3] Starting Backend (FastAPI)..."
echo ""

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    print_warning "Virtual environment not found. Running with system Python..."
    BACKEND_PYTHON="python3"
else
    BACKEND_PYTHON="venv/bin/python"
fi

# Start backend in background
if [ -f "src/main.py" ]; then
    $BACKEND_PYTHON -m uvicorn main:app --host 0.0.0.0 --port 8000 --reload &
    BACKEND_PID=$!
    sleep 3
    if kill -0 $BACKEND_PID 2>/dev/null; then
        print_status 0 "Backend started (PID: $BACKEND_PID)"
        echo "  • API: http://localhost:8000"
        echo "  • Docs: http://localhost:8000/docs"
    else
        print_warning "Backend failed to start. Check logs."
    fi
else
    print_warning "src/main.py not found. Skipping backend."
fi

# ==========================================
# Step 4: Start Frontend (Vue.js)
# ==========================================
echo ""
print_info "Starting Frontend (Vue.js)..."
echo ""

if [ -d "src/vue" ]; then
    cd src/vue
    if [ -f "package.json" ]; then
        # Check if node_modules exists
        if [ ! -d "node_modules" ]; then
            print_info "Installing frontend dependencies..."
            npm install
        fi

        # Start frontend in background
        npm run dev &
        FRONTEND_PID=$!
        sleep 5
        if kill -0 $FRONTEND_PID 2>/dev/null; then
            print_status 0 "Frontend started (PID: $FRONTEND_PID)"
            echo "  • App: http://localhost:5173"
        else
            print_warning "Frontend failed to start. Check logs."
        fi
    else
        print_warning "src/vue/package.json not found. Skipping frontend."
    fi
    cd ../..
else
    print_warning "src/vue directory not found. Skipping frontend."
fi

# ==========================================
# Summary
# ==========================================
echo ""
echo "=========================================="
echo -e "${GREEN}Reboot Complete!${NC}"
echo "=========================================="
echo ""
echo "Services running:"
echo "  • MySQL:      localhost:3306 (Docker)"
echo "  • Backend:    http://localhost:8000"
echo "  • Frontend:   http://localhost:5173"
echo "  • API Docs:   http://localhost:8000/docs"
echo ""
echo "To stop all services: ./stop.sh"
echo ""
echo "Background PIDs:"
if [ -n "$BACKEND_PID" ]; then
    echo "  • Backend:    $BACKEND_PID"
fi
if [ -n "$FRONTEND_PID" ]; then
    echo "  • Frontend:   $FRONTEND_PID"
fi
echo ""

#!/bin/bash

# Minseo Asset Management Portal - Start Script (macOS)
# This script will install and start all necessary components

set -e

echo "=========================================="
echo "Minseo Asset Management Portal"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ $2${NC}"
    else
        echo -e "${RED}✗ $2${NC}"
    fi
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Function to install brew package with conflict resolution
install_brew_package() {
    local package=$1
    local cask=$2
    local binary_path=$3

    print_info "Checking $package..."

    # Check if already installed and working
    if command -v $package &> /dev/null; then
        # Check version
        if [ "$package" == "docker" ]; then
            print_status 0 "Docker is already installed"
            return 0
        else
            local version=$($package --version 2>&1 | head -n1)
            print_status 0 "$package is already installed ($version)"
            return 0
        fi
    fi

    print_info "Installing $package via Homebrew..."

    if [ "$cask" == "true" ]; then
        # Handle cask packages (like Docker)
        if brew list --casks | grep -q "$package"; then
            print_info "$package is already installed as a cask."
            return 0
        fi

        # Try to install, handle conflicts
        if brew install --cask "$package" 2>&1; then
            print_status 0 "$package installed successfully"
        else
            print_warning "Initial install failed, attempting to fix conflicts..."
            # Try to force link or reinstall
            brew reinstall --cask "$package" 2>&1 || {
                print_warning "Could not install $package. Please install manually from https://www.docker.com/products/docker-desktop"
                return 1
            }
        fi
    else
        # Handle formula packages
        if brew list | grep -q "$package"; then
            print_info "$package is already installed."
            return 0
        fi

        if brew install "$package" 2>&1; then
            print_status 0 "$package installed successfully"
        else
            print_warning "Install failed, trying with --force..."
            brew install --force "$package" 2>&1 || {
                print_warning "Could not install $package."
                return 1
            }
        fi
    fi

    return 0
}

# Check if running on macOS
if [[ ! "$(uname)" == "Darwin" ]]; then
    print_warning "This script is optimized for macOS. continuing anyway..."
fi

# ==========================================
# Step 1: Check and install Homebrew if needed
# ==========================================
echo ""
echo "[1/7] Checking Homebrew..."
if ! command -v brew &> /dev/null; then
    print_info "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    print_status $? "Homebrew installed"
else
    print_status 0 "Homebrew is already installed"
    # Update homebrew
    print_info "Updating Homebrew..."
    brew update --auto-update 2>/dev/null || true
    print_status 0 "Homebrew updated"
fi

# ==========================================
# Step 2: Check and install Docker
# ==========================================
echo ""
echo "[2/7] Checking Docker..."
# Check if docker command exists
if command -v docker &> /dev/null; then
    # Check if docker app is running
    if docker info &> /dev/null 2>&1; then
        print_status 0 "Docker is already installed and running"
    else
        print_warning "Docker command exists but daemon is not running."
        print_info "Please start Docker Desktop from Applications folder."
        read -p "Press Enter to continue after starting Docker Desktop, or Ctrl+C to cancel..."
    fi
else
    # Docker not found, need to install
    print_info "Docker not found. Checking for conflicts..."

    # Function to clean up conflicting binaries
    clean_conflicts() {
        print_info "Cleaning up conflicting binaries..."
        sudo rm -f /usr/local/bin/hub-tool /usr/local/bin/docker /usr/local/bin/docker-compose 2>/dev/null || true
        rm -f /usr/local/bin/hub-tool /usr/local/bin/docker /usr/local/bin/docker-compose 2>/dev/null || true
        find /usr/local/bin -name "*hub*" -type l -delete 2>/dev/null || true
        find /usr/local/bin -name "*docker*" -type l -delete 2>/dev/null || true
        print_status 0 "Conflicts cleaned"
    }

    # Clean conflicts BEFORE install
    if [ -f "/usr/local/bin/hub-tool" ] || [ -f "/usr/local/bin/docker" ]; then
        clean_conflicts
    fi

    print_info "Installing Docker Desktop..."
    brew install --cask docker
    print_status $? "Docker installed"

    print_warning ""
    print_warning "============================================"
    print_warning "IMPORTANT: Please start Docker Desktop now!"
    print_warning "============================================"
    print_warning "1. Open 'Docker' from Applications folder"
    print_warning "2. Wait for Docker to fully start (whale icon in menu bar)"
    print_warning "3. Run this script again to complete setup"
    print_warning ""

    read -p "Press Enter once Docker Desktop has started..."

    # Verify Docker is running
    if ! docker info &> /dev/null 2>&1; then
        print_warning "Docker still not running. Please try again."
        exit 1
    fi

    print_status 0 "Docker is now running"
fi

# ==========================================
# Step 3: Check and install Docker Compose
# ==========================================
echo ""
echo "[3/7] Checking Docker Compose..."
# Check for docker-compose or docker compose
if command -v docker-compose &> /dev/null; then
    print_status 0 "Docker Compose is already installed ($(docker-compose --version | head -n1))"
elif docker compose version &> /dev/null 2>&1; then
    print_status 0 "Docker Compose (plugin) is already installed"
else
    print_info "Installing Docker Compose..."

    # Check for conflicting hub-tool binary and remove it
    if [ -f "/usr/local/bin/hub-tool" ]; then
        print_warning "Found conflicting hub-tool binary. Removing automatically..."
        if sudo rm -f /usr/local/bin/hub-tool 2>/dev/null; then
            print_status 0 "Removed /usr/local/bin/hub-tool"
        else
            rm -f /usr/local/bin/hub-tool 2>/dev/null || true
            if [ ! -f "/usr/local/bin/hub-tool" ]; then
                print_status 0 "Removed /usr/local/bin/hub-tool (without sudo)"
            fi
        fi
    fi

    # Also check for docker binary that might be conflicting
    if [ -f "/usr/local/bin/docker" ]; then
        print_info "Found docker binary. Removing to avoid conflicts..."
        if sudo rm -f /usr/local/bin/docker 2>/dev/null; then
            print_status 0 "Removed /usr/local/bin/docker"
        else
            rm -f /usr/local/bin/docker 2>/dev/null || true
        fi
    fi

    if brew install docker-compose 2>&1; then
        print_status $? "Docker Compose installed"
    else
        print_warning "Could not install docker-compose via brew."
        print_info "Docker Compose is included with Docker Desktop, using 'docker compose' instead."
    fi
fi

# ==========================================
# Step 4: Check and install Python
# ==========================================
echo ""
echo "[4/7] Checking Python..."
if ! command -v python3 &> /dev/null; then
    print_info "Python 3 not found. Installing via Homebrew..."
    brew install python
    print_status $? "Python 3 installed"
else
    PYTHON_VERSION=$(python3 --version 2>&1 | cut -d' ' -f2)
    print_status 0 "Python 3 is already installed ($PYTHON_VERSION)"

    # Update python if it's old
    PYTHON_MAJOR=$(python3 -c "import sys; print(sys.version_info.major)")
    PYTHON_MINOR=$(python3 -c "import sys; print(sys.version_info.minor)")

    if [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 11 ]; then
        print_warning "Python version is below 3.11. Consider updating: brew upgrade python"
    fi
fi

# ==========================================
# Step 5: Setup Python virtual environment
# ==========================================
echo ""
echo "[5/7] Setting up Python virtual environment..."
if [ ! -d "venv" ]; then
    print_info "Creating virtual environment..."
    python3 -m venv venv
    print_status $? "Virtual environment created"
else
    print_status 0 "Virtual environment already exists"
fi

# Activate virtual environment
print_info "Activating virtual environment..."
source venv/bin/activate

# Install Python dependencies
print_info "Installing Python dependencies..."
pip install --upgrade pip > /dev/null 2>&1
pip install -r requirements.txt
print_status $? "Python dependencies installed"

# ==========================================
# Step 6: Setup Node.js and frontend
# ==========================================
echo ""
echo "[6/7] Checking Node.js..."
if ! command -v node &> /dev/null; then
    print_info "Node.js not found. Installing via Homebrew..."
    brew install node
    print_status $? "Node.js installed"
else
    NODE_VERSION=$(node --version)
    print_status 0 "Node.js is already installed ($NODE_VERSION)"

    # Check for node version conflicts
    if [ -f "/usr/local/bin/node" ]; then
        # Check if it's a symlink to nvm or homebrew
        if [ -L "/usr/local/bin/node" ]; then
            TARGET=$(readlink "/usr/local/bin/node")
            if [[ "$TARGET" == *".nvm"* ]]; then
                print_info "Node is managed by nvm. Skipping brew install."
            fi
        fi
    fi
fi

# Check npm
if ! command -v npm &> /dev/null; then
    print_warning "npm not found. Please install Node.js first."
else
    print_status 0 "npm is already available"

    # Fix npm cache permissions (common issue on macOS)
    if [ -d "/Users/parkminseo/.npm" ]; then
        print_info "Fixing npm cache permissions..."
        if sudo chown -R $(whoami) /Users/parkminseo/.npm 2>/dev/null; then
            print_status 0 "npm cache permissions fixed"
        else
            print_warning "Could not fix npm cache permissions automatically."
            print_warning "Please run: sudo chown -R $(whoami) /Users/parkminseo/.npm"
        fi
    fi

    # Install frontend dependencies
    if [ -d "src/vue" ]; then
        print_info "Installing frontend dependencies..."
        cd src/vue
        if [ ! -d "node_modules" ]; then
            npm install
            print_status $? "Frontend dependencies installed"
        else
            print_status 0 "Frontend dependencies already installed"
        fi
        cd ../..
    fi
fi

# ==========================================
# Step 7: Start Docker services
# ==========================================
echo ""
echo "[7/7] Starting Docker services..."

# Final cleanup check before starting services
if [ -f "/usr/local/bin/hub-tool" ]; then
    print_warning "Found hub-tool binary still present. Removing..."
    sudo rm -f /usr/local/bin/hub-tool 2>/dev/null || rm -f /usr/local/bin/hub-tool 2>/dev/null || true
fi

# Clean up any stopped containers that might be holding ports
print_info "Cleaning up Docker resources..."
docker container prune -f 2>/dev/null || true
docker network prune -f 2>/dev/null || true

# Kill any process using our ports
print_info "Checking for processes using our ports (8000, 5173, 3306)..."
for port in 8000 5173 3306; do
    pid=$(lsof -ti :$port 2>/dev/null || true)
    if [ -n "$pid" ]; then
        print_warning "Found process $pid using port $port. Killing..."
        kill -9 $pid 2>/dev/null || true
        print_status 0 "Killed process $pid on port $port"
    else
        print_status 0 "Port $port is free"
    fi
done

# Check if Docker Desktop is running
if docker info &> /dev/null 2>&1; then
    print_status 0 "Docker is running"
else
    print_warning "Docker is not running."
    print_info "Attempting to start Docker Desktop..."
    print_info "This may take 30-60 seconds."
    echo ""
    # Check if docker-compose command exists
    if command -v docker-compose &> /dev/null; then
        docker-compose up -d --build
    elif docker compose version &> /dev/null 2>&1; then
        docker compose up -d --build
    else
        print_warning "Docker Compose not available. Please install it first."
        exit 1
    fi
    print_status $? "Docker services started"
else
    print_warning "Docker is not running."
    print_info "Attempting to start Docker Desktop..."

    # Try to start Docker Desktop
    if [ -d "/Applications/Docker.app" ]; then
        open /Applications/Docker.app

        print_warning "Docker Desktop is starting..."
        print_warning "Please wait for the whale icon in the menu bar to stop bouncing (about 30 seconds)"

        # Wait for Docker to start (max 60 seconds)
        countdown=60
        while [ $countdown -gt 0 ]; do
            if docker info &> /dev/null 2>&1; then
                print_status 0 "Docker is now running!"
                break
            fi
            sleep 1
            countdown=$((countdown - 1))
            printf "."
        done
        echo ""

        if ! docker info &> /dev/null 2>&1; then
            print_warning "Docker failed to start automatically."
            print_warning "Please open Docker Desktop manually from Applications folder."
            exit 1
        fi

        print_status 0 "Docker is now running!"
    else
        print_warning "Docker Desktop is not installed at /Applications/Docker.app"
        print_warning "Please install Docker Desktop from https://www.docker.com/products/docker-desktop"
        exit 1
    fi
fi

# Start Docker services
if command -v docker-compose &> /dev/null; then
    print_info "Starting services with docker-compose..."
    docker-compose up -d --build
    print_status $? "Docker services started"
elif docker compose version &> /dev/null 2>&1; then
    print_info "Starting services with docker compose..."
    docker compose up -d --build
    print_status $? "Docker services started"
else
    print_warning "Docker Compose not available. Please install it first."
    exit 1
fi

# ==========================================
# Summary
# ==========================================
echo ""
echo "=========================================="
echo -e "${GREEN}Setup Complete!${NC}"
echo "=========================================="
echo ""
echo "Access the application:"
echo "  • Frontend: ${BLUE}http://localhost:5173${NC}"
echo "  • Backend API: ${BLUE}http://localhost:8000${NC}"
echo "  • API Docs: ${BLUE}http://localhost:8000/docs${NC}"
echo ""
echo "Database: MySQL on localhost:3306"
echo "  • User: ${BLUE}minseo_user${NC}"
echo "  • Password: ${BLUE}minseo_pass123${NC}"
echo ""
echo "Useful commands:"
echo "  • ./stop.sh      - Stop all services"
echo "  • ./logs.sh      - View logs"
echo "  • ./restart.sh   - Restart all services"
echo ""
echo "To stop services manually:"
echo "  docker-compose down"
echo ""

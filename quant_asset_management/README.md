# Minseo Asset Management Portal

개인 자산을 한 곳에서 통합 관리할 수 있는 웹 애플리케이션입니다.

## Features

- **주식 관리**: 한국/미국 주식 투자 내역 관리, 실시간 가격 확인
- **은행 계좌**: 여러 은행 계좌 잔액 및 거래내역 확인
- **부동산 관리**: 부동산 자산가치 추적, 대출 정보 관리
- **포트폴리오 분석**: 자산별 비중 분석, 수익률 확인
- **투자 트렌드 분석**: AI 기반 투자 추천

## Tech Stack

### Backend
- Python 3.11+
- FastAPI
- SQLAlchemy
- MySQL

### Frontend
- Vue.js 3
- TypeScript
- Pinia
- Vue Router
- CSS3

## Getting Started

### Option 1: Using Docker (Recommended)

```bash
# Start all services (MySQL, Backend, Frontend)
./start.sh

# Stop services
./stop.sh

# View logs
./logs.sh
```

### Option 2: Local Development

#### Prerequisites

- Python 3.11+
- Node.js 18+
- MySQL 8.0+

#### Installation

```bash
# Backend setup
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
# Edit .env with your configuration

# Frontend setup
cd src/vue
npm install
npm run dev

# Run backend
cd ../..
python -m uvicorn src.main:app --reload
```

## Project Structure

```
minseo_asset_management/
├── src/
│   ├── api/              # API endpoints
│   ├── models/           # Database models
│   ├── schemas/          # Pydantic schemas
│   ├── services/         # Business logic
│   ├── config/           # Configuration
│   ├── utils/            # Utility functions
│   ├── main.py           # FastAPI entry point
│   └── vue/              # Frontend application
│       ├── components/   # Vue components
│       ├── pages/        # Page components
│       ├── stores/       # Pinia stores
│       ├── router/       # Vue Router
│       └── styles/       # CSS styles
├── tests/
├── requirements.txt
└── README.md
```

## API Documentation

Run the backend server and visit: http://localhost:8000/docs

## Docker Compose Services

| Service | Port | Description |
|---------|------|-------------|
| frontend | 5173 | Vue.js frontend |
| backend | 8000 | FastAPI backend |
| db | 3306 | MySQL database |

## Default Database Credentials

- User: `minseo_user`
- Password: `minseo_pass123`
- Database: `minseo_asset`

## Troubleshooting

### Docker Installation Conflicts (hub-tool)

If you see an error like `Error: It seems there is already a Binary at '/usr/local/bin/hub-tool'`, this is a known issue with Docker Desktop installation.

The `start.sh` script will now **automatically remove** the conflicting hub-tool binary before installing Docker.

If you want to manually fix it:
```bash
./cleanup-hub-tool.sh
```

This script will:
1. Find and remove conflicting binaries (`hub-tool`, `docker`)
2. Use sudo if needed
3. Confirm removal success

### Docker Desktop Already Installed but Broken

If Docker Desktop is installed but not working properly:
```bash
# Uninstall Docker Desktop completely
brew uninstall --cask docker

# Clean up conflicting binaries
./cleanup-hub-tool.sh

# Reinstall via start.sh
./start.sh
```

### Docker Desktop Not Starting

1. Open Docker from Applications folder
2. Wait for the whale icon in the menu bar to stop bouncing
3. Run `./start.sh` again

### Permission Denied Errors

Some operations require sudo. If you see permission errors:
```bash
sudo chmod +x *.sh
```

### npm EACCES Error

If you see `npm error code EACCES` or permission errors during npm install:
```bash
./fix-npm-perm.sh
```

This will fix the npm cache folder ownership issue that commonly occurs on macOS.


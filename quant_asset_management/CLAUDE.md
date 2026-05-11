# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Minseo Asset Management Portal - A full-stack personal asset management system supporting stocks, banks, real estate, and crypto assets.

## Quick Start (macOS)

### Single Command Installation
```bash
./start.sh
```
This will automatically install and configure:
- Homebrew (if needed)
- Docker Desktop
- Docker Compose
- Python 3 virtual environment with dependencies
- Node.js and frontend dependencies
- MySQL, Backend, and Frontend services

### Available Commands
```bash
./start.sh         # Install and start everything
./stop.sh          # Stop all services
./restart.sh       # Restart all services
./logs.sh          # View logs
./uninstall.sh     # Remove everything (with confirmation)
```

## Tech Stack

- **Backend**: Python 3.11+, FastAPI, SQLAlchemy, MySQL
- **Frontend**: Vue.js 3, TypeScript, Pinia, Vue Router
- **API Docs**: Available at `http://localhost:8000/docs`

## Docker Services

| Service | Port | Description |
|---------|------|-------------|
| frontend | 5173 | Vue.js frontend |
| backend | 8000 | FastAPI backend |
| db | 3306 | MySQL database |

## MySQL Credentials

- User: `minseo_user`
- Password: `minseo_pass123`
- Database: `minseo_asset`

## Project Structure

```
src/
├── api/              # FastAPI endpoints (endpoints/, router.py)
├── models/           # Database models (base.py, portfolio.py, transaction.py)
├── schemas/          # Pydantic schemas (stock, bank, real_estate, portfolio)
├── services/         # Business logic (stock_service, bank_service, etc.)
├── config/           # Configuration (database.py, settings.py)
├── utils/            # Utility functions
└── vue/              # Frontend application
    ├── components/   # Vue components (layout/)
    ├── pages/        # Page components (Dashboard, Stocks, Banks, etc.)
    ├── stores/       # Pinia state management
    ├── router/       # Vue Router configuration
    └── styles/       # CSS styles and variables
```

## Core Models

- **StockAsset**: Stock investments with ticker, quantity, avg price
- **BankAsset**: Bank accounts with balance, interest rate
- **RealEstateAsset**: Property with market value, loan remaining
- **CashAsset**: Cash and cash equivalents
- **CryptoAsset**: Cryptocurrency holdings
- **Portfolio**: Aggregated assets with allocation tracking
- **Transaction**: Asset movement records

## API Endpoints

- `/api/stocks` - Stock investment management
- `/api/banks` - Bank account management
- `/api/real-estates` - Property management
- `/api/portfolio` - Portfolio summary and analytics
- `/api/transactions` - Transaction records

## AI Features

- Asset allocation recommendations
- Stock trend prediction
- Portfolio rebalancing suggestions
- Spending pattern analysis

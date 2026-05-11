"""Stock-related schemas"""
from datetime import datetime
from typing import Optional, List
from pydantic import BaseModel, Field


class StockPrice(BaseModel):
    """Stock price data"""
    ticker: str
    price: float
    change: float
    change_rate: float
    volume: int
    timestamp: datetime


class StockInfo(BaseModel):
    """Stock information"""
    ticker: str
    name: str
    market: str  # KOSPI, KOSDAQ, NASDAQ
    sector: str
    pe_ratio: Optional[float] = None
    pb_ratio: Optional[float] = None
    dividend_yield: Optional[float] = None
    market_cap: Optional[float] = None


class StockHolding(BaseModel):
    """User's stock holding"""
    ticker: str
    quantity: float
    avg_purchase_price: float
    current_price: float
    total_value: float
    profit: float
    profit_rate: float

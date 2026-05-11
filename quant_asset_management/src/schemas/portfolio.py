"""Portfolio-related schemas"""
from datetime import datetime
from typing import Optional, Dict, List
from pydantic import BaseModel


class PortfolioSummary(BaseModel):
    """Portfolio summary with asset allocation"""
    total_value: float
    total_profit: float
    total_profit_rate: float
    asset_allocation: Dict[str, float]  # asset_type -> percentage
    currency: str = "KRW"


class AssetAllocation(BaseModel):
    """Asset allocation breakdown"""
    asset_type: str
    value: float
    percentage: float
    profit: float
    profit_rate: float


class PortfolioPerformance(BaseModel):
    """Portfolio performance metrics"""
    period: str  # 1D, 1W, 1M, 3M, 6M, 1Y, ALL
    start_value: float
    end_value: float
    profit: float
    profit_rate: float
    annualized_return: Optional[float] = None


class PortfolioHistory(BaseModel):
    """Historical portfolio data"""
    date: datetime
    total_value: float
    cash: float
    stocks: float
    real_estate: float
    bank: float
    crypto: float

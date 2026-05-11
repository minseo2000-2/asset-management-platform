"""Stock endpoint"""
from fastapi import APIRouter, HTTPException, Depends
from typing import List, Optional
from pydantic import BaseModel

router = APIRouter()


class StockRequest(BaseModel):
    ticker: str
    quantity: float
    purchase_price: float
    market: str = "KOSPI"


class StockResponse(BaseModel):
    id: int
    ticker: str
    name: str
    quantity: float
    purchase_price: float
    current_price: float
    total_value: float
    profit: float
    profit_rate: float


@router.get("", response_model=List[StockResponse])
async def list_stocks():
    """List all user stocks"""
    pass


@router.post("", response_model=StockResponse)
async def add_stock(request: StockRequest):
    """Add new stock investment"""
    pass


@router.get("/{ticker}", response_model=StockResponse)
async def get_stock(ticker: str):
    """Get stock details"""
    pass


@router.put("/{ticker}")
async def update_stock(ticker: str, request: StockRequest):
    """Update stock holding"""
    pass


@router.delete("/{ticker}")
async def delete_stock(ticker: str):
    """Remove stock from portfolio"""
    pass


@router.get("/{ticker}/price")
async def get_stock_price(ticker: str):
    """Get real-time stock price"""
    pass

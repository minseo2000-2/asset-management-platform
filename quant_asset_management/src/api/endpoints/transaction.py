"""Transaction endpoint"""
from fastapi import APIRouter, HTTPException, Depends
from typing import List, Optional
from pydantic import BaseModel

router = APIRouter()


class TransactionRequest(BaseModel):
    asset_type: str
    asset_id: Optional[int] = None
    transaction_type: str
    amount: float
    price_per_unit: Optional[float] = None
    notes: str = ""


class TransactionResponse(BaseModel):
    id: int
    asset_type: str
    transaction_type: str
    amount: float
    total_amount: float
    executed_at: str
    status: str


@router.get("", response_model=List[TransactionResponse])
async def list_transactions():
    """List all transactions"""
    pass


@router.post("", response_model=TransactionResponse)
async def add_transaction(request: TransactionRequest):
    """Record new transaction"""
    pass


@router.get("/{transaction_id}")
async def get_transaction(transaction_id: int):
    """Get transaction details"""
    pass

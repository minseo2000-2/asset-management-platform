"""Transaction model for tracking asset movements"""
from datetime import datetime
from typing import Optional, Literal
from pydantic import BaseModel, Field

TransactionType = Literal["BUY", "SELL", "DEPOSIT", "WITHDRAW", "DIVIDEND", "INTEREST", "TRANSFER"]
TransactionStatus = Literal["PENDING", "COMPLETED", "CANCELLED"]


class Transaction(BaseModel):
    """Asset transaction record"""
    id: Optional[int] = None
    user_id: int
    asset_id: Optional[int] = None
    asset_type: Optional[str] = None
    transaction_type: TransactionType
    amount: float
    price_per_unit: Optional[float] = None
    total_amount: float
    currency: str = "KRW"
    status: TransactionStatus = "COMPLETED"
    executed_at: datetime = Field(default_factory=datetime.now)
    created_at: datetime = Field(default_factory=datetime.now)
    notes: str = ""
    fee: float = 0.0

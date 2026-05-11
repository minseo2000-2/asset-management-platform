"""Bank-related schemas"""
from datetime import datetime
from typing import Optional, Literal
from pydantic import BaseModel

AccountType = Literal["CHECKING", "SAVINGS", "FIXED_DEPOSIT", "CREDIT_CARD", "LOAN"]


class BankAccount(BaseModel):
    """Bank account information"""
    id: int
    user_id: int
    bank_name: str
    account_number: str
    account_type: AccountType
    balance: float
    interest_rate: Optional[float] = None
    account_name: str
    created_at: datetime
    is_primary: bool = False


class BankTransaction(BaseModel):
    """Bank transaction"""
    id: int
    account_id: int
    amount: float
    balance_after: float
    description: str
    transaction_type: str
    executed_at: datetime

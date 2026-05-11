"""Bank endpoint"""
from fastapi import APIRouter, HTTPException, Depends
from typing import List
from pydantic import BaseModel

router = APIRouter()


class BankAccountRequest(BaseModel):
    bank_name: str
    account_number: str
    account_type: str
    balance: float = 0.0
    account_name: str = ""


class BankAccountResponse(BaseModel):
    id: int
    bank_name: str
    account_number: str
    account_type: str
    balance: float
    account_name: str
    is_primary: bool


@router.get("", response_model=List[BankAccountResponse])
async def list_accounts():
    """List all bank accounts"""
    pass


@router.post("", response_model=BankAccountResponse)
async def add_account(request: BankAccountRequest):
    """Add new bank account"""
    pass


@router.get("/{account_id}")
async def get_account(account_id: int):
    """Get account details"""
    pass


@router.put("/{account_id}")
async def update_account(account_id: int, request: BankAccountRequest):
    """Update account information"""
    pass


@router.delete("/{account_id}")
async def delete_account(account_id: int):
    """Remove account"""
    pass


@router.post("/{account_id}/transactions")
async def add_transaction(account_id: int):
    """Record bank transaction"""
    pass

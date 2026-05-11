"""Bank data service"""
from typing import List, Optional
from datetime import datetime

from schemas.bank import BankAccount, BankTransaction


class BankService:
    """Service for bank account data"""

    async def fetch_account_balance(
        self,
        account_number: str,
        bank_code: str,
    ) -> float:
        """Fetch account balance from bank API"""
        # API call implementation
        pass

    async def fetch_transactions(
        self,
        account_id: int,
        start_date: datetime,
        end_date: datetime,
    ) -> List[BankTransaction]:
        """Fetch account transactions"""
        # Database or API call
        pass

    def calculate_interest(
        self,
        principal: float,
        rate: float,
        days: int,
    ) -> float:
        """Calculate simple interest"""
        return principal * (rate / 100) * (days / 365)

    def get_bank_list(self) -> List[dict]:
        """Get list of supported banks"""
        return [
            {"code": "03", "name": "KB국민은행"},
            {"code": "04", "name": "신한은행"},
            {"code": "08", "name": "하나은행"},
            {"code": "11", "name": "KB손보"},
            {"code": "23", "name": "카카오뱅크"},
            {"code": "25", "name": "토스뱅크"},
        ]


bank_service = BankService()

"""Portfolio service for asset aggregation"""
from typing import List, Dict
from datetime import datetime

from models.base import AssetModel
from models.portfolio import Portfolio
from models.transaction import Transaction


class PortfolioService:
    """Service for portfolio management"""

    def calculate_portfolio_value(self, assets: List[AssetModel]) -> float:
        """Calculate total portfolio value"""
        return sum(asset.current_value for asset in assets)

    def calculate_portfolio_profit(
        self,
        assets: List[AssetModel],
        total_cost: float,
    ) -> dict:
        """Calculate portfolio profit and return"""
        total_value = self.calculate_portfolio_value(assets)
        profit = total_value - total_cost
        profit_rate = (profit / total_cost) * 100 if total_cost > 0 else 0

        return {
            "total_value": total_value,
            "total_cost": total_cost,
            "profit": profit,
            "profit_rate": profit_rate,
        }

    def get_asset_allocation(self, assets: List[AssetModel]) -> Dict[str, float]:
        """Calculate asset class allocation"""
        allocation = {}
        total_value = self.calculate_portfolio_value(assets)

        if total_value == 0:
            return allocation

        for asset in assets:
            asset_type = asset.asset_type
            if asset_type not in allocation:
                allocation[asset_type] = 0
            allocation[asset_type] += asset.current_value

        # Normalize to percentage
        for key in allocation:
            allocation[key] = (allocation[key] / total_value) * 100

        return allocation

    def create_portfolio_history(
        self,
        transactions: List[Transaction],
        start_date: datetime,
    ) -> List[dict]:
        """Create portfolio history from transactions"""
        # History calculation
        pass


portfolio_service = PortfolioService()

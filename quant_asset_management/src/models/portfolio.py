"""Portfolio model for asset aggregation"""
from datetime import datetime
from typing import Optional, List
from pydantic import BaseModel, Field

from .base import AssetModel


class Portfolio(BaseModel):
    """User portfolio containing all assets"""
    id: Optional[int] = None
    user_id: int
    name: str = "기본 포트폴리오"
    total_value: float = 0.0
    total_profit: float = 0.0
    total_profit_rate: float = 0.0
    asset_classes: dict = Field(default_factory=dict)  # 분자산별 비중
    created_at: datetime = Field(default_factory=datetime.now)
    updated_at: datetime = Field(default_factory=datetime.now)
    assets: List[AssetModel] = Field(default_factory=list)

    def calculate_total_value(self) -> float:
        """Calculate total portfolio value"""
        self.total_value = sum(asset.current_value for asset in self.assets)
        return self.total_value

    def calculate_asset_allocation(self) -> dict:
        """Calculate asset class allocation"""
        if not self.total_value:
            return {}

        self.asset_classes = {}
        for asset in self.assets:
            asset_type = asset.asset_type
            if asset_type not in self.asset_classes:
                self.asset_classes[asset_type] = 0.0
            self.asset_classes[asset_type] += asset.current_value

        # Normalize to percentage
        for key in self.asset_classes:
            self.asset_classes[key] = (self.asset_classes[key] / self.total_value) * 100

        return self.asset_classes

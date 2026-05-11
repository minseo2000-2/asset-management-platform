"""Base model for asset management"""
from datetime import datetime
from typing import Optional
from pydantic import BaseModel, Field


class AssetBase(BaseModel):
    """Base asset model"""
    id: Optional[int] = None
    user_id: int
    asset_type: str
    name: str
    current_value: float
    currency: str = "KRW"
    created_at: datetime = Field(default_factory=datetime.now)
    updated_at: datetime = Field(default_factory=datetime.now)


class StockAsset(AssetBase):
    """Stock investment asset"""
    asset_type: str = "stock"
    ticker: str
    quantity: float
    avg_purchase_price: float
    market: str  # KOSPI, KOSDAQ, NASDAQ, etc.


class BankAsset(AssetBase):
    """Bank deposit asset"""
    asset_type: str = "bank"
    account_number: str
    bank_name: str
    account_type: str  # checking, savings, fixed_deposit
    balance: float
    interest_rate: float = 0.0


class RealEstateAsset(AssetBase):
    """Real estate asset"""
    asset_type: str = "real_estate"
    property_type: str  # apartment, villa, land, office
    address: str
    area_sqm: float
    market_value: float
    loan_remaining: float = 0.0
    purchase_price: float = 0.0


class CashAsset(AssetBase):
    """Cash and cash equivalent asset"""
    asset_type: str = "cash"
    location: str  # wallet, bank, etc.
    balance: float


class CryptoAsset(AssetBase):
    """Cryptocurrency asset"""
    asset_type: str = "crypto"
    coin_name: str
    ticker: str
    quantity: float
    avg_purchase_price: float


# Type alias for union of all asset types
AssetModel = StockAsset | BankAsset | RealEstateAsset | CashAsset | CryptoAsset

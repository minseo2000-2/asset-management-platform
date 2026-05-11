"""Real estate-related schemas"""
from datetime import datetime
from typing import Optional, Literal
from pydantic import BaseModel

PropertyType = Literal["APARTMENT", "VILLA", "LAND", "OFFICE", "FACTORY", "COMMERCIAL"]


class RealEstate(BaseModel):
    """Real estate asset"""
    id: int
    user_id: int
    property_type: PropertyType
    name: str
    address: str
    detailed_address: str
    area_sqm: float
    area_py: float  # 평수
    market_value: float
    loan_remaining: float = 0.0
    loan_bank: Optional[str] = None
    interest_rate: Optional[float] = None
    purchase_price: float = 0.0
    purchase_date: Optional[datetime] = None
    annual_tax: float = 0.0
    insurance_cost: float = 0.0
    management_fee: float = 0.0
    rent_income: float = 0.0  # 월세/전세 수익
    created_at: datetime


class RealEstateValuation(BaseModel):
    """Real estate valuation record"""
    id: int
    real_estate_id: int
    valuation_date: datetime
    market_value: float
    valuation_method: str  # 감정평가, 시장가격, 자가평가
    notes: Optional[str] = None

"""Real estate endpoint"""
from fastapi import APIRouter, HTTPException, Depends
from typing import List
from pydantic import BaseModel

router = APIRouter()


class RealEstateRequest(BaseModel):
    property_type: str
    name: str
    address: str
    area_sqm: float
    market_value: float
    loan_remaining: float = 0.0
    rent_income: float = 0.0


class RealEstateResponse(BaseModel):
    id: int
    property_type: str
    name: str
    address: str
    area_sqm: float
    market_value: float
    loan_remaining: float
    equity: float  # 시가 - 대출금
    rent_income: float


@router.get("", response_model=List[RealEstateResponse])
async def list_properties():
    """List all real estate properties"""
    pass


@router.post("", response_model=RealEstateResponse)
async def add_property(request: RealEstateRequest):
    """Add new property"""
    pass


@router.get("/{property_id}")
async def get_property(property_id: int):
    """Get property details"""
    pass


@router.put("/{property_id}")
async def update_property(property_id: int, request: RealEstateRequest):
    """Update property information"""
    pass


@router.delete("/{property_id}")
async def delete_property(property_id: int):
    """Remove property"""
    pass


@router.post("/{property_id}/valuation")
async def add_valuation(property_id: int):
    """Add new valuation record"""
    pass

"""API endpoints package"""
from fastapi import APIRouter

from .endpoints import stock, bank, real_estate, portfolio, transaction

api_router = APIRouter()

api_router.include_router(stock.router, prefix="/api/stocks", tags=["stocks"])
api_router.include_router(bank.router, prefix="/api/banks", tags=["banks"])
api_router.include_router(real_estate.router, prefix="/api/real-estates", tags=["real-estates"])
api_router.include_router(portfolio.router, prefix="/api/portfolio", tags=["portfolio"])
api_router.include_router(transaction.router, prefix="/api/transactions", tags=["transactions"])


@api_router.get("/health")
async def health_check():
    return {"status": "ok"}

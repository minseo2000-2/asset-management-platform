"""Application settings"""
from pydantic_settings import BaseSettings
from typing import Optional


class Settings(BaseSettings):
    """Application settings"""

    # App settings
    app_name: str = "Minseo Asset Management"
    app_version: str = "1.0.0"
    debug: bool = False

    # Database settings
    database_url: str = "mysql+pymysql://root:password@localhost:3306/minseo_asset"

    # JWT settings
    secret_key: str = "your-secret-key-here"
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 30

    # Stock API settings
    stock_api_url: str = "https://api.stockservice.com"

    # Real estate API settings
    realestate_api_url: str = "https://api.realestate.com"

    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()

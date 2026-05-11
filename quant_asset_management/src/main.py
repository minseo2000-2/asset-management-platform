"""Main application entry point"""
import sys
import os

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

# Add src to path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from api.router import api_router

# Create FastAPI app
app = FastAPI(
    title="Minseo Asset Management API",
    description="Personal Asset Management Portal API",
    version="1.0.0",
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    return {
        "message": "Minseo Asset Management Portal",
        "version": "1.0.0",
        "endpoints": {
            "docs": "/docs",
            "api": "/api/*",
        },
    }


app.include_router(api_router)

if __name__ == "__main__":
    import uvicorn

    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)

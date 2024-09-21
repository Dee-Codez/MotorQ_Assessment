from fastapi import APIRouter

from . import health, db

api_routers = APIRouter()

api_routers.include_router(health.router)
api_routers.include_router(db.router)
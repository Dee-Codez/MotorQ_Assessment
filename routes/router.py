from fastapi import APIRouter

from . import health, db, vehicles

api_routers = APIRouter()

api_routers.include_router(health.router)
api_routers.include_router(db.router)
api_routers.include_router(vehicles.router)
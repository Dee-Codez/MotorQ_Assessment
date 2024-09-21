from fastapi import FastAPI, Request, Response, APIRouter
from fastapi.responses import PlainTextResponse
from fastapi.middleware.cors import CORSMiddleware
from slowapi import Limiter, _rate_limit_exceeded_handler
from slowapi.util import get_remote_address
from slowapi.errors import RateLimitExceeded

from routes.router import api_routers

limiter = Limiter(key_func=get_remote_address)
app = FastAPI(
    title="MotorQ Assessment",
    description="This is the API Documentation Interface for the MotorQ assessment.",
    version="0.1.0"
)

app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler) # type: ignore

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(api_routers)

@app.get("/default")
@limiter.limit("60/minute")
async def home(request: Request):
    return PlainTextResponse("test")


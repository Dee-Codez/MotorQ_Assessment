from fastapi import APIRouter, status, HTTPException, Request, Response
from slowapi import Limiter
from slowapi.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)

router = APIRouter(
    prefix="/health",
    tags=["health_check"],
    responses={404: {"description": "Not found"}},
)

@router.get("/", status_code=status.HTTP_200_OK)
@limiter.limit("5/minute")
async def health_check(request: Request, response: Response):
    return {"status": "ok"}
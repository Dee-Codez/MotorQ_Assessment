import psycopg2
import polars as pl
from fastapi import APIRouter, status, HTTPException, Request, Response
from slowapi import Limiter
from slowapi.util import get_remote_address

from schemas.db import GetTableParams
from utils.getDB import get_cursor

router = APIRouter(
    prefix="/db",
    tags=["database_check"],
    responses={404: {"description": "Not found"}},
)

limiter = Limiter(key_func=get_remote_address)

@router.get("/test", status_code=status.HTTP_200_OK)
@limiter.limit("5/minute")
async def test_connection(request: Request, response: Response):
    try:
        cursor = get_cursor()
        cursor.execute("SELECT 1")
        cursor.close()
        return {"status": "db connected"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    

@router.post("/getTable", status_code=status.HTTP_200_OK)
@limiter.limit("3/minute")
async def query_db(request: Request, response: Response, params: GetTableParams):
    try:
        cursor = get_cursor()
        table_name = params.table_name
        columns = ",".join(params.columns) if params.columns else "*"
        cursor.execute(f"SELECT {columns} FROM {table_name}")
        result = cursor.fetchall()
        
        return {"status": "query successful", "data": result}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


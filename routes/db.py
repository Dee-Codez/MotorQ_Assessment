import psycopg2
import polars as pl
from fastapi import APIRouter, status, HTTPException, Request, Response
from slowapi import Limiter
from slowapi.util import get_remote_address

from schemas.db import GetTableParams
from utils.getDB import get_cursor
from components.db import get_table_schema, generate_fake_data

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
    
@router.get("/getTables", status_code=status.HTTP_200_OK)
@limiter.limit("3/minute")
async def get_tables(request: Request, response: Response):
    try:
        cursor = get_cursor()
        cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
        tables = cursor.fetchall()
        return {"status": "query successful", "data": tables}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@router.get("/getTableMetadata", status_code=status.HTTP_200_OK)
@limiter.limit("3/minute")
async def get_table_metadata(request: Request, response: Response, table_name: str):
    try:
        cursor = get_cursor()
        schema = get_table_schema(cursor, table_name)
        cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
        num_rows = cursor.fetchone()
        return {"status": "query successful", "num_rows":num_rows, "schema": schema}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    

@router.post("/getTable", status_code=status.HTTP_200_OK)
@limiter.limit("3/minute")
async def query_db(request: Request, response: Response, params: GetTableParams):
    """
        This function queries the database for the specified table and columns.
        If no columns are specified, all columns are returned.
        If columns are specified, only those columns are returned.
        
            Args:
                params (GetTableParams): The table name and columns to query.

            
            Returns:
                dict: A dictionary containing the query status, number of rows, and the query data.
        
        
    """
    try:
        cursor = get_cursor()
        table_name = params.table_name
        columns = ",".join(params.columns) if params.columns else "*"
        cursor.execute(f"SELECT {columns} FROM {table_name}")
        result = cursor.fetchall()
        
        return {"status": "query successful", "num_rows":len(result) , "data": result}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@router.post("/seedTable", status_code=status.HTTP_200_OK)
@limiter.limit("3/minute")
async def seed_table(request: Request, response: Response, params: GetTableParams, seed_amount: int = 10):
    try:
        cursor = get_cursor()
        table_name = params.table_name
        columns = ",".join(params.columns) if params.columns else "*"

        schema = get_table_schema(cursor, table_name)
        fake_data = generate_fake_data(schema,seed_amount)

        columns = ", ".join(fake_data[0].keys())
        values_list = []
        for record in fake_data:
            values = ", ".join([f"'{v}'" if v is not None else 'NULL' for v in record.values()])
            values_list.append(f"({values})")
        values_str = ", ".join(values_list)
        insert_query = f"INSERT INTO {table_name} ({columns}) VALUES {values_str}"
        cursor.execute(insert_query)
        cursor.connection.commit()

        return {"status": "seed successful", "data" : fake_data}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))



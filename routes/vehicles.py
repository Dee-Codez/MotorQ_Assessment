from fastapi import APIRouter, status, HTTPException, Request, Response
from slowapi import Limiter
from slowapi.util import get_remote_address
from datetime import datetime, timedelta

from utils.getDB import get_cursor

router = APIRouter(
    prefix="/vehicles",
    tags=["vehicles"],
    responses={404: {"description": "Not found"}},
)

@router.get("/distance_travelled", status_code=status.HTTP_200_OK)
async def distance_travelled(request: Request, response: Response):
    """
        This function queries the database for the total distance traveled by a vehicle.
        
            Args:
                vehicle_id (int): The vehicle ID.
                
            Returns:
                dict: A dictionary containing the status of the query and the total distance traveled.
                
    """
    try:
        cur = get_cursor()
        query = """
                SELECT 
                    V.make, 
                    V.model, 
                    O.owner_name, 
                    SUM(T.distance_traveled) AS total_distance
                FROM 
                    Trips T
                JOIN 
                    Vehicles V ON T.vehicle_id = V.vehicle_id
                JOIN 
                    Owners O ON V.owner_id = O.owner_id
                WHERE 
                    T.start_time <= CURRENT_DATE - INTERVAL '30 days'
                GROUP BY 
                    V.make, V.model, O.owner_name
            """
        cur.execute(query)
        results = cur.fetchall()
        data = []
        for row in results:
            vehicle_data = {
                "make": row[0],
                "model": row[1],
                "owner": {
                    "name": row[2]
                },
                "total_distance_traveled": row[3]
            }
            data.append(vehicle_data)
        return {"status": "query successful", "data": data}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    

@router.get("/sensor_anomalies", status_code=status.HTTP_200_OK)
async def sensor_anomalies(request: Request, response: Response):
    """
        This function queries the database for sensor anomalies.
        
            Returns:
                dict: A dictionary containing the status of the query and the sensor anomalies.
                
    """
    try:
        cur = get_cursor()
        query = """
                SELECT 
                    V.vehicle_id,
                    V.make,
                    V.model,
                    S.sensor_type,
                    S.sensor_reading,
                    S.reading_timestamp
                FROM 
                    Sensors S
                JOIN 
                    Vehicles V ON S.vehicle_id = V.vehicle_id
                WHERE 
                    (S.sensor_type = 'Speed' AND S.sensor_reading > 120)
                    OR (S.sensor_type = 'Fuel Level' AND S.sensor_reading < 10)
            """
        cur.execute(query)
        results = cur.fetchall()
        
        # Create a nested JSON response
        data = []
        for row in results:
            anomaly_data = {
                "vehicle_id": row[0],
                "make": row[1],
                "model": row[2],
                "sensor": {
                    "type": row[3],
                    "value": row[4],
                    "timestamp": row[5]
                }
            }
            data.append(anomaly_data)
        
        return {"status": "query successful", "data": data}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/{vehicle_id}/maintenance_history", status_code=status.HTTP_200_OK)
async def maintenance_history(vehicle_id: int):
    """
        This function queries the database for the maintenance history of a vehicle.
        
            Args:
                vehicle_id (int): The vehicle ID.
                
            Returns:
                dict: A dictionary containing the status of the query and the maintenance history of the vehicle.
                
    """
    try:
        cur = get_cursor()
        query = f"""
                SELECT 
                    M.maintenance_type,
                    M.maintenance_date,
                    M.maintenance_cost
                FROM 
                    Maintenance M
                WHERE 
                    M.vehicle_id = {vehicle_id}
            """
        cur.execute(query)
        results = cur.fetchall()
        
        # Create a JSON response
        data = []
        for row in results:
            maintenance_record = {
                "maintenance_type": row[0],
                "maintenance_date": row[1],
                "maintenance_cost": row[2]
            }
            data.append(maintenance_record)
        
        return {"status": "query successful", "data": data}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
@router.get("/frequent_trips", status_code=status.HTTP_200_OK)
async def frequent_trips():
    """
        This function queries the database for vehicles with more than 5 trips in the last 7 days.
        
            Returns:
                dict: A dictionary containing the status of the query and the vehicles with more than 5 trips in the last 7 days.
                
    """
    try:
        cur = get_cursor()
        seven_days_ago = datetime.now() - timedelta(days=7)
        query = """
                SELECT 
                    V.vehicle_id,
                    V.make,
                    V.model,
                    COUNT(T.trip_id) AS trip_count
                FROM 
                    Trips T
                JOIN 
                    Vehicles V ON T.vehicle_id = V.vehicle_id
                WHERE 
                    T.start_time <= CURRENT_DATE - INTERVAL '7 days'
                GROUP BY 
                    V.vehicle_id, V.make, V.model
                HAVING 
                    COUNT(T.trip_id) > 5
            """
        cur.execute(query, (seven_days_ago,))
        results = cur.fetchall()
        
        # Create a JSON response
        data = []
        for row in results:
            vehicle_data = {
                "vehicle_id": row[0],
                "make": row[1],
                "model": row[2],
                "trip_count": row[3]
            }
            data.append(vehicle_data)
        
        return {"status": "query successful", "data": data}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
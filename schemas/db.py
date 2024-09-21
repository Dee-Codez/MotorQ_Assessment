from pydantic import BaseModel
from typing import List, Optional

class GetTableParams(BaseModel):
    table_name: str
    columns: Optional[List[str]] = None
import mysql.connector
import os
from dotenv import load_dotenv

def get_db_connection():
    """Create and return a database connection"""
    load_dotenv()
    
    conn = mysql.connector.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        user=os.getenv('DB_USER', 'root'),
        password=os.getenv('MYSQL_ROOT_PASSWORD', ''),
        database=os.getenv('DB_NAME', 'tummy'),
        port=int(os.getenv('DB_PORT', 3306))
    )
    return conn 
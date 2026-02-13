# This script reads CSV files containing Formula 1 data and imports them into a SQL Server database.
# Make sure to adjust the SERVER_NAME, DATABASE_NAME, and DATA_FOLDER variables as needed before running the script.

import pandas as pd
from sqlalchemy import create_engine
import urllib
import os

# CONFIGURATION
SERVER_NAME = 'localhost'
DATABASE_NAME = 'F1_Data'

# Assuming CSV files are in the same directory as this script.
DATA_FOLDER = '.'

# CONNECT
params = urllib.parse.quote_plus(
    f'DRIVER={{ODBC Driver 17 for SQL Server}};'
    f'SERVER={SERVER_NAME};'
    f'DATABASE={DATABASE_NAME};'
    f'Trusted_Connection=yes;'
)
engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}")

# FILE LIST
files_to_load = [
    ('circuits.csv', 'circuits'),
    ('drivers.csv', 'drivers'),
    ('constructors.csv', 'constructors'),
    ('seasons.csv', 'seasons'),
    ('status.csv', 'status'),
    ('races.csv', 'races'),
    ('results.csv', 'results'),
    ('pit_stops.csv', 'pit_stops'),
    ('qualifying.csv', 'qualifying'),
    ('lap_times.csv', 'lap_times'),
    ('sprint_results.csv', 'sprint_results')
]

print(f"Looking for data in: {DATA_FOLDER}")

# LOAD LOOP
for file_name, table_name in files_to_load:
    file_path = os.path.join(DATA_FOLDER, file_name)
    
    if os.path.exists(file_path):
        print(f"Reading {file_name}...", end=" ")
        try:
            df = pd.read_csv(file_path)
            df.replace(r'\\N', None, regex=True, inplace=True)
            df.to_sql(table_name, con=engine, if_exists='append', index=False)
            print(f"Loaded {len(df)} rows into [{table_name}]")
        except Exception as e:
            print(f"\nError on {table_name}: {e}")
    else:
        print(f"File not found: {file_name}")

print("\nImport Finished!")

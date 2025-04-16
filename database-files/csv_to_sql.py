import pandas as pd
import os
import re

def clean_value(value):
    """Clean and format a value for SQL insertion."""
    if pd.isna(value) or value == '':
        return 'NULL'
    
    # Convert boolean values to integers
    if isinstance(value, bool):
        return '1' if value else '0'
    
    # Convert numeric values
    if isinstance(value, (int, float)):
        return str(value)
    
    # Handle date/time values
    if isinstance(value, pd.Timestamp):
        return f"'{value.strftime('%Y-%m-%d %H:%M:%S')}'"
    
    # Handle string values
    value = str(value)
    value = value.replace("'", "''")  # Escape single quotes
    return f"'{value}'"

def csv_to_sql_inserts(csv_path, table_name):
    """Convert a CSV file to SQL INSERT statements."""
    if not os.path.exists(csv_path):
        print(f"Warning: {csv_path} not found")
        return None
    
    try:
        df = pd.read_csv(csv_path)
        if df.empty:
            print(f"Warning: No data in {csv_path}")
            return None
        
        # Get column names
        columns = df.columns.tolist()
        
        # Start building the INSERT statement
        insert_stmt = f"\n\n-- Insert statements for table: {table_name}\n"
        insert_stmt += f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES\n"
        
        # Process each row
        values_list = []
        for _, row in df.iterrows():
            values = [clean_value(row[col]) for col in columns]
            values_list.append(f"({', '.join(values)})")
        
        # Join all value sets with commas
        insert_stmt += ',\n'.join(values_list) + ';'
        
        return insert_stmt
    except Exception as e:
        print(f"Error processing {csv_path}: {str(e)}")
        return None

def generate_sql_file():
    """Generate SQL insert statements from all CSV files in the directory."""
    csv_directory = "database-files/csv"
    sql_file_path = os.path.join("database-files", "tummy-base.sql")
    
    print(f"\nGenerating SQL inserts in {sql_file_path}...")
    wrote_any = False

    # Define the order of tables to process (based on dependencies)
    table_order = [
        "User",           # No dependencies
        "LogEntry",       # No dependencies
        "Tag",           # No dependencies
        "Meal",          # No dependencies
        "Alert",         # Depends on User and LogEntry
        "IssueReport",   # Depends on User and LogEntry
        "Blog",          # Depends on User and Meal
        "Meal_Tag",      # Depends on Meal and Tag
        "Saved_Meals",   # Depends on User and Meal
        "Interaction"    # Depends on User and Meal
    ]

    with open(sql_file_path, "a", encoding='utf-8') as sql_file:
        for table_name in table_order:
            csv_path = os.path.join(csv_directory, f"{table_name}.csv")
            if os.path.exists(csv_path):
                insert_block = csv_to_sql_inserts(csv_path, table_name)
                if insert_block:
                    print(f"Writing insert block for {table_name}")
                    sql_file.write(insert_block)
                    wrote_any = True

    if wrote_any:
        print(f"\nSuccess! SQL inserts written to {sql_file_path}")
    else:
        print("\nNo CSV files with data found in database-files/csv directory")

if __name__ == "__main__":
    generate_sql_file() 
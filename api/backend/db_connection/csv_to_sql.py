import csv
import os
from datetime import datetime

def csv_to_sql_inserts(csv_file, table_name):
    """Convert CSV data to SQL insert statements."""
    inserts = []
    with open(csv_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            # Handle different data types and NULL values
            values = []
            for key, value in row.items():
                if value == '':
                    values.append('NULL')
                elif key in ['Age', 'PrepTime', 'CookTime', 'TotalTime', 'ViewCount', 'LogID', 'AlertID', 'IssueID', 'GroupID', 'CategoryID']:
                    values.append(value)
                elif key in ['InclusionStatus', 'SavedStatus']:
                    values.append('1' if value.lower() == 'true' else '0')
                elif key in ['Timestamp', 'DateCreated', 'PublishDate', 'follow_date']:
                    if value:
                        values.append(f"'{value}'")
                    else:
                        values.append('NULL')
                else:
                    # Escape single quotes in string values
                    value = value.replace("'", "''")
                    values.append(f"'{value}'")
            
            insert = f"INSERT INTO {table_name} ({', '.join(row.keys())}) VALUES ({', '.join(values)});"
            inserts.append(insert)
    
    return inserts

def generate_sql_file(csv_dir, output_file):
    """Generate SQL file from all CSV files in directory."""
    with open(output_file, 'w', encoding='utf-8') as f:
        # Process each CSV file
        for filename in os.listdir(csv_dir):
            if filename.endswith('.csv'):
                table_name = os.path.splitext(filename)[0]
                csv_path = os.path.join(csv_dir, filename)
                
                f.write(f"-- Insert statements for table: {table_name}\n")
                inserts = csv_to_sql_inserts(csv_path, table_name)
                f.write('\n'.join(inserts))
                f.write('\n\n')

if __name__ == "__main__":
    csv_dir = "database-files/csv"
    output_file = "database-files/inserts.sql"
    generate_sql_file(csv_dir, output_file) 
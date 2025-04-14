import os
import csv

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

def format_value(value):
    # Handle boolean values represented as text
    if value.lower() == 'true':
        return 'TRUE'
    elif value.lower() == 'false':
        return 'FALSE'
    # If it's numeric, return as-is without quotes
    if is_number(value):
        return value
    # Otherwise, enclose the value in single quotes and escape inner single quotes by doubling them.
    return "'" + value.replace("'", "''") + "'"

def csv_to_insert(csv_path, table_name):
    """
    Reads the CSV file at csv_path and creates
    a list of SQL INSERT statements for the given table_name.
    """
    statements = []
    with open(csv_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        columns = reader.fieldnames
        for row in reader:
            cols = ", ".join(columns)
            # Format each value accordingly.
            vals = ", ".join(format_value(row[col]) for col in columns)
            statement = f"INSERT INTO {table_name} ({cols}) VALUES ({vals});"
            statements.append(statement)
    return statements

def process_all_csvs(directory):
    """
    Process every CSV file in the specified directory.
    Returns a dictionary with keys as table names and values as a list of SQL statements.
    Assumes that the CSV filename (without extension) is the table name.
    """
    sql_statements = {}
    for filename in os.listdir(directory):
        if filename.lower().endswith(".csv"):
            table_name = os.path.splitext(filename)[0]
            csv_path = os.path.join(directory, filename)
            statements = csv_to_insert(csv_path, table_name)
            sql_statements[table_name] = statements
            print(f"Processed {filename}: {len(statements)} rows")
    return sql_statements

def main():
    print("Starting script...")

    # Use the current directory since the script, CSVs and tummy-base.sql are together.
    csv_directory = "."
    
    # Process all CSV files in the current directory.
    all_inserts = process_all_csvs(csv_directory)

    # Path to the SQL file (in the same directory)
    sql_file_path = "tummy-base.sql"
    
    # Append the INSERT statements for each table into tummy-base.sql.
    with open(sql_file_path, "a", encoding='utf-8') as sql_file:
        for table, statements in all_inserts.items():
            sql_file.write(f"\n\n-- Insert statements for table: {table}\n")
            for stmt in statements:
                sql_file.write(stmt + "\n")
    
    print(f"All CSV data has been appended as INSERT statements to {sql_file_path}")

if __name__ == "__main__":
    main()

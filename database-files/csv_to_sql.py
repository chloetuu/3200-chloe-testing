import os
import csv

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

def format_value(value):
    if value.lower() == 'true':
        return 'TRUE'
    elif value.lower() == 'false':
        return 'FALSE'
    if value == '':
        return 'NULL'
    if is_number(value):
        return value
    return "'" + value.replace("'", "''") + "'"

def csv_to_bulk_insert(csv_path, table_name):
    with open(csv_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        columns = reader.fieldnames
        rows = []
        for row in reader:
            values = ", ".join(format_value(row[col]) for col in columns)
            rows.append(f"({values})")
        
        if not rows:
            print(f"[SKIP] No data in {csv_path}")
            return ""  # Skip empty CSVs

        insert_stmt = f"\n-- Insert statements for table: {table_name}\n" \
                      f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES\n" \
                      + ",\n".join(rows) + ";\n"
        return insert_stmt

def main():
    csv_directory = "."
    sql_file_path = "tummy-base.sql"

    if not os.path.exists(sql_file_path):
        print(f"[ERROR] tummy-base.sql does not exist in {os.getcwd()}")
        return

    print(f"[INFO] Writing inserts to {sql_file_path}\n")
    wrote_any = False

    with open(sql_file_path, "a", encoding='utf-8') as sql_file:
        for filename in os.listdir(csv_directory):
            if filename.endswith(".csv"):
                table_name = os.path.splitext(filename)[0]
                csv_path = os.path.join(csv_directory, filename)
                insert_block = csv_to_bulk_insert(csv_path, table_name)
                if insert_block:
                    sql_file.write(insert_block)
                    print(f"[DONE] {filename} -> {table_name}")
                    wrote_any = True

    if wrote_any:
        print("\n✅ All INSERT statements added to tummy-base.sql")
    else:
        print("\n⚠️ No CSV files processed. Make sure .csv files are in the same folder as the script.")

if __name__ == "__main__":
    main()

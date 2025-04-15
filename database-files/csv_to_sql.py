import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta
import os
import csv

# ---------- Data Generation Section ----------
fake = Faker()

def generate_csv_files():
    print("Generating CSV files...")
    os.makedirs('database-files', exist_ok=True)

    # User data
    users = []
    usernames = set()
    while len(users) < 35:
        username = fake.user_name()
        if username in usernames:
            continue
        usernames.add(username)
        users.append({
            "Username": username,
            "FirstName": fake.first_name(),
            "LastName": fake.last_name(),
            "Region": fake.state(),
            "ActivityLevel": random.choice(["Low", "Medium", "High"]),
            "Age": random.randint(18, 70),
            "InclusionStatus": random.choice([True, False]),
            "Bio": fake.text(100)
        })
    user_csv_path = "database-files/User.csv"
    pd.DataFrame(users).to_csv(user_csv_path, index=False)
    print(f"✅ Created {user_csv_path} with {len(users)} users")

    # Follows data
    follows = []
    user_list = list(usernames)
    for _ in range(125):
        follower = random.choice(user_list)
        followee = random.choice(user_list)
        if follower != followee:
            follows.append({
                "follower_id": follower,
                "followee_id": followee,
                "follow_date": fake.date_this_decade()
            })
    follows_df = pd.DataFrame(follows).drop_duplicates(subset=["follower_id", "followee_id"])
    follows_csv_path = "database-files/Follows.csv"
    follows_df.to_csv(follows_csv_path, index=False)
    print(f"✅ Created {follows_csv_path} with {len(follows_df)} follow relationships")

    # You can insert generation for other tables here...

    print("CSV generation completed!\n")

# ---------- SQL Insert Generation Section ----------
def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

def format_value(value):
    if isinstance(value, str):
        value = value.strip()
        if value.lower() == 'true':
            return 'TRUE'
        if value.lower() == 'false':
            return 'FALSE'
        if value == '':
            return 'NULL'
    if is_number(str(value)):
        return str(value)
    return "'" + str(value).replace("'", "''") + "'"

def csv_to_bulk_insert(csv_path, table_name):
    print(f"📄 Processing: {csv_path}")
    with open(csv_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        columns = reader.fieldnames
        rows = []
        row_count = 0
        for row in reader:
            row_count += 1
            if row_count <= 3:  # Show only the first 3 rows
                print(f"🔍 Sample Row: {row}")
            values = ", ".join(format_value(row[col]) for col in columns)
            rows.append(f"({values})")

        if not rows:
            print(f"⚠️ [SKIP] No data in {csv_path}")
            return ""

        insert_stmt = f"\n-- Insert statements for table: {table_name}\n" \
                      f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES\n" \
                      + ",\n".join(rows) + ";\n"
        return insert_stmt

def generate_sql_inserts():
    csv_directory = "database-files"
    sql_file_path = os.path.join(csv_directory, "tummy-base.sql")

    # Create fresh SQL file
    with open(sql_file_path, "w", encoding='utf-8') as sql_file:
        sql_file.write("-- AUTO-GENERATED SQL INSERT STATEMENTS\n\n")

    print(f"\n📝 Generating SQL inserts in {sql_file_path}...")
    wrote_any = False

    with open(sql_file_path, "a", encoding='utf-8') as sql_file:
        for filename in sorted(os.listdir(csv_directory)):
            if filename.endswith(".csv"):
                csv_path = os.path.join(csv_directory, filename)
                table_name = os.path.splitext(filename)[0]

                insert_block = csv_to_bulk_insert(csv_path, table_name)
                if insert_block:
                    print(f"✍️ Writing insert block for {table_name}")
                    sql_file.write(insert_block)
                    wrote_any = True

    if wrote_any:
        print(f"\n✅ Success! SQL inserts written to {sql_file_path}")
    else:
        print("\n⚠️ No CSV files with data found in database-files directory")

# ---------- Main Execution ----------
if __name__ == "__main__":
    # Step 1: Generate all CSV files
    generate_csv_files()

    # Step 2: Create SQL insert statements
    generate_sql_inserts()

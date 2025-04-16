import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta
import os
import csv
import re

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

    # Tag data
    tags = []
    cuisines = ["Italian", "Mexican", "Chinese", "Indian", "Japanese", "American", "Mediterranean"]
    allergies = ["Gluten", "Dairy", "Nuts", "Shellfish", "Eggs", "Soy"]
    meal_types = ["Breakfast", "Lunch", "Dinner", "Dessert", "Snack"]
    
    for cuisine in cuisines:
        for allergy in allergies:
            for meal_type in meal_types:
                tags.append({
                    "Cuisine": cuisine,
                    "Allergy": allergy,
                    "MealType": meal_type
                })
    tag_csv_path = "database-files/Tag.csv"
    pd.DataFrame(tags).to_csv(tag_csv_path, index=False)
    print(f"✅ Created {tag_csv_path} with {len(tags)} tags")

    # Meal data
    meals = []
    for _ in range(50):
        meals.append({
            "Name": fake.sentence(nb_words=3),
            "DateCreated": fake.date_this_decade(),
            "PrepTime": random.randint(10, 60),
            "CookTime": random.randint(15, 120),
            "Difficulty": random.choice(["Easy", "Medium", "Hard"]),
            "Ingredients": fake.text(200),
            "Instructions": fake.text(500)
        })
    meal_csv_path = "database-files/Meal.csv"
    pd.DataFrame(meals).to_csv(meal_csv_path, index=False)
    print(f"✅ Created {meal_csv_path} with {len(meals)} meals")

    # Meal_Tag data
    meal_tags = []
    for meal_id in range(1, len(meals) + 1):
        num_tags = random.randint(1, 5)
        selected_tags = random.sample(range(1, len(tags) + 1), num_tags)
        for tag_id in selected_tags:
            meal_tags.append({
                "RecipeID": meal_id,
                "TagID": tag_id
            })
    meal_tag_csv_path = "database-files/Meal_Tag.csv"
    pd.DataFrame(meal_tags).to_csv(meal_tag_csv_path, index=False)
    print(f"✅ Created {meal_tag_csv_path} with {len(meal_tags)} meal-tag relationships")

    # Blog data
    blogs = []
    for _ in range(30):
        blogs.append({
            "PublishDate": fake.date_time_this_year(),
            "Content": fake.text(1000),
            "Title": fake.sentence(nb_words=4),
            "Username": random.choice(user_list),
            "RecipeID": random.randint(1, len(meals))
        })
    blog_csv_path = "database-files/Blog.csv"
    pd.DataFrame(blogs).to_csv(blog_csv_path, index=False)
    print(f"✅ Created {blog_csv_path} with {len(blogs)} blogs")

    # Blog_Meal data
    blog_meals = []
    for blog_id in range(1, len(blogs) + 1):
        num_meals = random.randint(1, 3)
        selected_meals = random.sample(range(1, len(meals) + 1), num_meals)
        for meal_id in selected_meals:
            blog_meals.append({
                "BlogID": blog_id,
                "RecipeID": meal_id
            })
    blog_meal_csv_path = "database-files/Blog_Meal.csv"
    pd.DataFrame(blog_meals).to_csv(blog_meal_csv_path, index=False)
    print(f"✅ Created {blog_meal_csv_path} with {len(blog_meals)} blog-meal relationships")

    # Saved_Meals data
    saved_meals = []
    for username in user_list:
        num_saved = random.randint(0, 10)
        selected_meals = random.sample(range(1, len(meals) + 1), num_saved)
        for meal_id in selected_meals:
            saved_meals.append({
                "Username": username,
                "RecipeID": meal_id
            })
    saved_meals_csv_path = "database-files/Saved_Meals.csv"
    pd.DataFrame(saved_meals).to_csv(saved_meals_csv_path, index=False)
    print(f"✅ Created {saved_meals_csv_path} with {len(saved_meals)} saved meals")

    # Favorites data
    favorites = []
    for username in user_list:
        num_favorites = random.randint(0, 5)
        selected_meals = random.sample(range(1, len(meals) + 1), num_favorites)
        for meal_id in selected_meals:
            favorites.append({
                "Username": username,
                "RecipeID": meal_id
            })
    favorites_csv_path = "database-files/Favorites.csv"
    pd.DataFrame(favorites).to_csv(favorites_csv_path, index=False)
    print(f"✅ Created {favorites_csv_path} with {len(favorites)} favorites")

    # Added_Meals data
    added_meals = []
    for username in user_list:
        num_added = random.randint(0, 5)
        selected_meals = random.sample(range(1, len(meals) + 1), num_added)
        for meal_id in selected_meals:
            added_meals.append({
                "Username": username,
                "RecipeID": meal_id
            })
    added_meals_csv_path = "database-files/Added_Meals.csv"
    pd.DataFrame(added_meals).to_csv(added_meals_csv_path, index=False)
    print(f"✅ Created {added_meals_csv_path} with {len(added_meals)} added meals")

    # DemographicGroupData
    demographic_groups = []
    group_types = ["Age Group", "Region", "Activity Level", "Dietary Preference"]
    for group_type in group_types:
        if group_type == "Age Group":
            values = ["18-25", "26-35", "36-45", "46-55", "56+"]
        elif group_type == "Region":
            values = ["Northeast", "Southeast", "Midwest", "Southwest", "West"]
        elif group_type == "Activity Level":
            values = ["Low", "Medium", "High"]
        else:
            values = ["Vegetarian", "Vegan", "Gluten-Free", "Dairy-Free", "None"]
        
        for value in values:
            demographic_groups.append({
                "GroupType": group_type,
                "GroupValue": value
            })
    demographic_csv_path = "database-files/DemographicGroupData.csv"
    pd.DataFrame(demographic_groups).to_csv(demographic_csv_path, index=False)
    print(f"✅ Created {demographic_csv_path} with {len(demographic_groups)} demographic groups")

    # UserDemographic data
    user_demographics = []
    for username in user_list:
        num_groups = random.randint(1, 3)
        selected_groups = random.sample(range(1, len(demographic_groups) + 1), num_groups)
        for group_id in selected_groups:
            user_demographics.append({
                "Username": username,
                "GroupID": group_id
            })
    user_demographic_csv_path = "database-files/UserDemographic.csv"
    pd.DataFrame(user_demographics).to_csv(user_demographic_csv_path, index=False)
    print(f"✅ Created {user_demographic_csv_path} with {len(user_demographics)} user demographics")

    # CategoryData
    categories = []
    category_names = ["Appetizers", "Main Dishes", "Desserts", "Beverages", "Sides", "Breakfast", "Lunch", "Dinner"]
    for name in category_names:
        categories.append({
            "Name": name
        })
    category_csv_path = "database-files/CategoryData.csv"
    pd.DataFrame(categories).to_csv(category_csv_path, index=False)
    print(f"✅ Created {category_csv_path} with {len(categories)} categories")

    # RecipeData
    recipe_data = []
    for meal_id in range(1, len(meals) + 1):
        recipe_data.append({
            "Name": meals[meal_id - 1]["Name"],
            "SavedStatus": random.randint(0, 1),
            "CategoryID": random.randint(1, len(categories)),
            "ViewCount": random.randint(0, 1000)
        })
    recipe_data_csv_path = "database-files/RecipeData.csv"
    pd.DataFrame(recipe_data).to_csv(recipe_data_csv_path, index=False)
    print(f"✅ Created {recipe_data_csv_path} with {len(recipe_data)} recipe data entries")

    # Interaction data
    interactions = []
    for _ in range(35):  # Generate 35 interactions
        interactions.append({
            "Username": random.choice(user_list),  # Changed from UserID to Username
            "RecipeID": random.randint(1, len(meals)),
            "InteractionType": random.choice(["View", "Like", "Comment", "Share"]),
            "Timestamp": fake.date_time_this_year()
        })
    interaction_csv_path = "database-files/Interaction.csv"
    pd.DataFrame(interactions).to_csv(interaction_csv_path, index=False)
    print(f"✅ Created {interaction_csv_path} with {len(interactions)} interactions")

    print("CSV generation completed!\n")

# ---------- SQL Insert Generation Section ----------
def clean_value(value):
    if value == '':
        return 'NULL'
    try:
        # Try to convert to float/int
        float(value)
        return value
    except ValueError:
        # If it's a string, escape single quotes and wrap in quotes
        value = value.replace("'", "''")
        return f"'{value}'"

def csv_to_bulk_insert(csv_path, table_name):
    if not os.path.exists(csv_path):
        print(f"⚠️ Warning: {csv_path} not found")
        return None

    try:
        with open(csv_path, 'r', encoding='utf-8') as file:
            reader = csv.reader(file)
            headers = next(reader)  # Get column names from first row
            
            # Read all rows
            rows = list(reader)
            if not rows:
                print(f"⚠️ Warning: No data in {csv_path}")
                return None

            # Start building the INSERT statement
            insert_stmt = f"\n\n-- Insert statements for table: {table_name}\n"
            insert_stmt += f"INSERT INTO {table_name} ({', '.join(headers)}) VALUES\n"

            # Process each row
            values_list = []
            for row in rows:
                # Clean and format each value
                cleaned_values = []
                for val in row:
                    if val == '':
                        cleaned_values.append('NULL')
                    else:
                        try:
                            # Try to convert to float/int
                            float(val)
                            cleaned_values.append(val)
                        except ValueError:
                            # If it's a string, escape single quotes and wrap in quotes
                            val = val.replace("'", "''")
                            cleaned_values.append(f"'{val}'")
                values_list.append(f"({', '.join(cleaned_values)})")

            # Join all value sets with commas
            insert_stmt += ',\n'.join(values_list) + ';'
            
            return insert_stmt
    except Exception as e:
        print(f"⚠️ Error processing {csv_path}: {str(e)}")
        return None

def generate_sql_inserts():
    csv_directory = "database-files"
    sql_file_path = os.path.join(csv_directory, "tummy-base.sql")

    # Create fresh SQL file with table creation statements
    with open(sql_file_path, "w", encoding='utf-8') as sql_file:
        sql_file.write("""
DROP DATABASE IF EXISTS Tummy;
CREATE DATABASE Tummy;
USE Tummy;

-- Table: User
CREATE TABLE User (
    Username VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Region VARCHAR(50),
    ActivityLevel VARCHAR(50),
    Age INT,
    Bio TEXT
);

-- Table: Follows
CREATE TABLE Follows (
    follower_id VARCHAR(50),
    followee_id VARCHAR(50),
    follow_date DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (follower_id, followee_id),
    FOREIGN KEY (follower_id) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (followee_id) REFERENCES User(Username) ON DELETE CASCADE
);

-- Table: Tag
CREATE TABLE Tag (
    TagID INT AUTO_INCREMENT PRIMARY KEY,
    Cuisine VARCHAR(50),
    Allergy VARCHAR(50),
    MealType VARCHAR(50)
);

-- Table: Meal
CREATE TABLE Meal (
    RecipeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    DateCreated DATE DEFAULT (CURRENT_DATE),
    PrepTime INT,
    CookTime INT,
    TotalTime INT GENERATED ALWAYS AS (PrepTime + CookTime) STORED,
    Difficulty VARCHAR(20) NOT NULL,
    Ingredients TEXT NOT NULL,
    Instructions TEXT NOT NULL
);

-- Table: Meal_Tag (Many-to-Many)
CREATE TABLE Meal_Tag (
    RecipeID INT,
    TagID INT,
    PRIMARY KEY (RecipeID, TagID),
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE,
    FOREIGN KEY (TagID) REFERENCES Tag(TagID) ON DELETE CASCADE
);

-- Table: Blog
CREATE TABLE Blog (
    BlogID INT AUTO_INCREMENT PRIMARY KEY,
    PublishDate DATETIME,
    Content MEDIUMTEXT,
    Title VARCHAR(100),
    Username VARCHAR(50),
    RecipeID INT,
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE SET NULL
);

-- Table: Blog_Meal (Many-to-Many)
CREATE TABLE Blog_Meal (
    BlogID INT,
    RecipeID INT,
    PRIMARY KEY (BlogID, RecipeID),
    FOREIGN KEY (BlogID) REFERENCES Blog(BlogID) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE
);

-- Table: Saved_Meals (Many-to-Many)
CREATE TABLE Saved_Meals (
    Username VARCHAR(50),
    RecipeID INT,
    PRIMARY KEY (Username, RecipeID),
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE
);

-- Table: Favorites (Many-to-Many)
CREATE TABLE Favorites (
    Username VARCHAR(50),
    RecipeID INT,
    PRIMARY KEY (Username, RecipeID),
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE
);

-- Table: Added_Meals (Many-to-Many)
CREATE TABLE Added_Meals (
    Username VARCHAR(50),
    RecipeID INT,
    PRIMARY KEY (Username, RecipeID),
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE
);

-- Table: DemographicGroupData
CREATE TABLE DemographicGroupData (
    GroupID INT AUTO_INCREMENT PRIMARY KEY,
    GroupType VARCHAR(50),
    GroupValue VARCHAR(50)
);

-- Table: UserDemographic (Many-to-Many)
CREATE TABLE UserDemographic (
    Username VARCHAR(50),
    GroupID INT,
    PRIMARY KEY (Username, GroupID),
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (GroupID) REFERENCES DemographicGroupData(GroupID) ON DELETE CASCADE
);

-- Table: CategoryData
CREATE TABLE CategoryData (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Table: RecipeData
CREATE TABLE RecipeData (
    RecipeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    SavedStatus INT,
    CategoryID INT,
    ViewCount INT,
    FOREIGN KEY (CategoryID) REFERENCES CategoryData(CategoryID) ON DELETE SET NULL
);

-- Table: Interaction
CREATE TABLE Interaction (
    InteractionID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50),  # Changed from UserID
    RecipeID INT,
    InteractionType VARCHAR(50),
    Timestamp DATETIME,
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE
);

-- Table: LogEntry
CREATE TABLE LogEntry (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Timestamp DATETIME,
    ErrorMessage TEXT,
    SeverityLevel VARCHAR(20),
    Source VARCHAR(100),
    Details TEXT
);
""")

    print(f"\n📝 Generating SQL inserts in {sql_file_path}...")
    wrote_any = False

    # Define the order of tables to process (based on dependencies)
    table_order = [
        "User",           # No dependencies
        "Tag",           # No dependencies
        "Meal",          # No dependencies
        "CategoryData",  # No dependencies
        "DemographicGroupData",  # No dependencies
        "LogEntry",      # No dependencies
        "Follows",       # Depends on User
        "Meal_Tag",      # Depends on Meal and Tag
        "Blog",          # Depends on User and Meal
        "Blog_Meal",     # Depends on Blog and Meal
        "Saved_Meals",   # Depends on User and Meal
        "Added_Meals",   # Depends on User and Meal
        "UserDemographic",  # Depends on User and DemographicGroupData
        "RecipeData",    # Depends on CategoryData
        "Interaction"    # Depends on User and Meal
    ]

    with open(sql_file_path, "a", encoding='utf-8') as sql_file:
        for table_name in table_order:
            csv_path = os.path.join(csv_directory, f"{table_name}.csv")
            if os.path.exists(csv_path):
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

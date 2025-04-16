import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta
import os
import uuid

fake = Faker()

# Create directory if it doesn't exist
os.makedirs('database-files/csv', exist_ok=True)

# Generate User data
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
        "Age": random.randint(18, 70),
        "Bio": fake.text(100),
        "ActivityLevel": random.choice(["Low", "Medium", "High"]),
        "InclusionStatus": random.choice([True, False])
    })

users_df = pd.DataFrame(users)
users_df.to_csv("database-files/csv/User.csv", index=False)

# Convert usernames set to list for random.choice()
username_list = list(usernames)

# Generate LogEntry data
log_entries = []
for i in range(1, 36):
    log_entries.append({
        "LogID": i,
        "Timestamp": fake.date_time_this_decade(),
        "SeverityLevel": random.choice(["INFO", "WARNING", "ERROR", "CRITICAL"]),
        "Source": fake.domain_name(),
        "Details": fake.text(200),
        "ErrorMessage": fake.sentence()
    })

log_entries_df = pd.DataFrame(log_entries)
log_entries_df.to_csv("database-files/csv/LogEntry.csv", index=False)

# Generate Alert data
alerts = []
for i in range(1, 36):
    alerts.append({
        "AlertID": i,
        "Type": random.choice(["System", "User", "Security", "Performance"]),
        "Timestamp": fake.date_time_this_decade(),
        "AssignedTo": random.choice(username_list),
        "LogID": random.randint(1, 35)
    })

alerts_df = pd.DataFrame(alerts)
alerts_df.to_csv("database-files/csv/Alert.csv", index=False)

# Generate IssueReport data
issue_reports = []
for i in range(1, 36):
    issue_reports.append({
        "IssueID": i,
        "Status": random.choice(["OPEN", "IN_PROGRESS", "RESOLVED", "CLOSED"]),
        "Description": fake.text(300),
        "Timestamp": fake.date_time_this_decade(),
        "ReportedBy": random.choice(username_list),
        "LogID": random.randint(1, 35)
    })

issue_reports_df = pd.DataFrame(issue_reports)
issue_reports_df.to_csv("database-files/csv/Issue.csv", index=False)

# Generate Meal data
meals = []
for i in range(1, 36):
    prep_time = random.randint(5, 30)
    cook_time = random.randint(10, 60)
    meals.append({
        "RecipeID": i,
        "Name": fake.word().capitalize() + " " + fake.word().capitalize(),
        "DateCreated": fake.date_this_decade(),
        "PrepTime": prep_time,
        "CookTime": cook_time,
        "TotalTime": prep_time + cook_time,
        "Difficulty": random.choice(["Easy", "Medium", "Hard"]),
        "Ingredients": fake.text(200),
        "Instructions": fake.text(500),
        "ViewCount": random.randint(0, 1000)
    })

meals_df = pd.DataFrame(meals)
meals_df.to_csv("database-files/csv/Meal.csv", index=False)

# Generate Blog data
blogs = []
for i in range(1, 36):
    blogs.append({
        "BlogID": i,
        "Title": fake.sentence(nb_words=4),
        "Content": fake.text(1000),
        "PublishDate": fake.date_this_decade(),
        "Username": random.choice(username_list),
        "RecipeID": random.randint(1, 35)
    })

blogs_df = pd.DataFrame(blogs)
blogs_df.to_csv("database-files/csv/Blog.csv", index=False)

# Generate Tag data
tags = []
tag_names = ["Vegetarian", "Vegan", "Gluten-Free", "Dairy-Free", "Quick", "Healthy", 
             "Low-Carb", "High-Protein", "Budget-Friendly", "Family-Friendly"]
for i, tag_name in enumerate(tag_names, 1):
    tags.append({
        "TagID": i,
        "TagName": tag_name
    })

tags_df = pd.DataFrame(tags)
tags_df.to_csv("database-files/csv/Tag.csv", index=False)

# Generate Meal_Tag bridge table
meal_tags = []
for _ in range(150):
    meal_tags.append({
        "RecipeID": random.randint(1, 35),
        "TagID": random.randint(1, len(tag_names))
    })

meal_tags_df = pd.DataFrame(meal_tags).drop_duplicates(subset=["RecipeID", "TagID"])
meal_tags_df.to_csv("database-files/csv/Meal_Tag.csv", index=False)

# Generate Saved_Meals bridge table
saved_meals = []
for _ in range(150):
    saved_meals.append({
        "Username": random.choice(username_list),
        "RecipeID": random.randint(1, 35)
    })

saved_meals_df = pd.DataFrame(saved_meals).drop_duplicates(subset=["Username", "RecipeID"])
saved_meals_df.to_csv("database-files/csv/Saved_Meals.csv", index=False)

# Generate Interaction data
interactions = []
for i in range(1, 36):
    interactions.append({
        "InteractionID": i,
        "Timestamp": fake.date_time_this_decade(),
        "InteractionType": random.choice(["VIEW", "LIKE", "COMMENT", "SHARE"]),
        "RecipeID": random.randint(1, 35),
        "UserID": random.choice(username_list)
    })

interactions_df = pd.DataFrame(interactions)
interactions_df.to_csv("database-files/csv/Interaction.csv", index=False)

print("All CSV files generated successfully in database-files/csv directory!") 
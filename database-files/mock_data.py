import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta
import os  # Added for directory handling

fake = Faker()

# Create directory if it doesn't exist
os.makedirs('database-files', exist_ok=True)

# Generate User data (strong entity, 30-40 rows)
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

users_df = pd.DataFrame(users)

# Generate Follows (bridge table)
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

# Generate Tag data (strong entity, 30-40 rows)
tags = []
for i in range(1, 36):
    tags.append({
        "TagID": i,
        "Cuisine": random.choice(["Italian", "Chinese", "Mexican", "Indian", "French", "Japanese", "Thai"]),
        "Allergy": random.choice(["None", "Peanuts", "Dairy", "Gluten", "Soy", "Shellfish"]),
        "MealType": random.choice(["Breakfast", "Lunch", "Dinner", "Snack", "Dessert"])
    })

tags_df = pd.DataFrame(tags)

# Generate Meal data (strong entity, 30-40 rows)
meals = []
for i in range(1, 36):
    prep = random.randint(5, 30)
    cook = random.randint(10, 60)
    meals.append({
        "RecipeID": i,
        "Name": fake.word().capitalize() + " Meal",
        "DateCreated": fake.date_this_decade(),
        "PrepTime": prep,
        "CookTime": cook,
        "Difficulty": random.choice(["Easy", "Medium", "Hard"]),
        "Ingredients": fake.text(200),
        "Instructions": fake.text(300),
        "FavoriteStatus": random.choice([True, False])
    })

meals_df = pd.DataFrame(meals)

# Generate Meal_Tag (bridge table, 125+ rows)
meal_tags = []
for _ in range(150):
    meal_tags.append({
        "RecipeID": random.randint(1, 35),
        "TagID": random.randint(1, 35)
    })

meal_tags_df = pd.DataFrame(meal_tags).drop_duplicates(subset=["RecipeID", "TagID"])

# Save initial CSVs
users_df.to_csv("database-files/User.csv", index=False)
follows_df.to_csv("database-files/Follows.csv", index=False)
tags_df.to_csv("database-files/Tag.csv", index=False)
meals_df.to_csv("database-files/Meal.csv", index=False)
meal_tags_df.to_csv("database-files/Meal_Tag.csv", index=False)

# Generate Blog data (strong entity, 30-40 rows)
blogs = []
for i in range(1, 36):
    blogs.append({
        "BlogID": i,
        "PublishDate": fake.date_time_this_decade(),
        "Content": fake.text(500),
        "Title": fake.sentence(6),
        "Username": random.choice(user_list),
        "RecipeID": random.randint(1, 35)
    })

blogs_df = pd.DataFrame(blogs)

# Generate Blog_Meal (bridge table, 125+ rows)
blog_meals = []
for _ in range(150):
    blog_meals.append({
        "BlogID": random.randint(1, 35),
        "RecipeID": random.randint(1, 35)
    })

blog_meals_df = pd.DataFrame(blog_meals).drop_duplicates(subset=["BlogID", "RecipeID"])

# Generate Saved_Meals (bridge table, 125+ rows)
saved_meals = []
for _ in range(150):
    saved_meals.append({
        "Username": random.choice(user_list),
        "RecipeID": random.randint(1, 35)
    })

saved_meals_df = pd.DataFrame(saved_meals).drop_duplicates(subset=["Username", "RecipeID"])

# Generate Added_Meals (bridge table, 125+ rows)
added_meals = []
for _ in range(150):
    added_meals.append({
        "Username": random.choice(user_list),
        "RecipeID": random.randint(1, 35)
    })

added_meals_df = pd.DataFrame(added_meals).drop_duplicates(subset=["Username", "RecipeID"])

# Generate DemographicGroupData (strong entity, 30-40 rows)
demographics = []
for i in range(1, 36):
    demographics.append({
        "GroupID": i,
        "GroupType": random.choice(["Gender", "Income", "Education", "Ethnicity"]),
        "GroupValue": fake.word().capitalize()
    })

demographics_df = pd.DataFrame(demographics)

# Generate UserDemographic (bridge table, 125+ rows)
user_demographics = []
for _ in range(150):
    user_demographics.append({
        "UserID": random.choice(user_list),
        "GroupID": random.randint(1, 35)
    })

user_demographics_df = pd.DataFrame(user_demographics).drop_duplicates(subset=["UserID", "GroupID"])

# Generate CategoryData (strong entity, 30-40 rows)
categories = []
for i in range(1, 36):
    categories.append({
        "CategoryID": i,
        "Name": fake.word().capitalize()
    })

categories_df = pd.DataFrame(categories)

# Generate RecipeData (strong entity, 30-40 rows)
recipes = []
for i in range(1, 36):
    recipes.append({
        "RecipeID": i,
        "Name": fake.word().capitalize() + " Dish",
        "SavedStatus": random.choice([True, False]),
        "CategoryID": random.randint(1, 35),
        "ViewCount": random.randint(0, 5000)
    })

recipe_data_df = pd.DataFrame(recipes)

# Save additional CSVs
blogs_df.to_csv("database-files/Blog.csv", index=False)
blog_meals_df.to_csv("database-files/Blog_Meal.csv", index=False)
saved_meals_df.to_csv("database-files/Saved_Meals.csv", index=False)
added_meals_df.to_csv("database-files/Added_Meals.csv", index=False)
demographics_df.to_csv("database-files/DemographicGroupData.csv", index=False)
user_demographics_df.to_csv("database-files/UserDemographic.csv", index=False)
categories_df.to_csv("database-files/CategoryData.csv", index=False)
recipe_data_df.to_csv("database-files/RecipeData.csv", index=False)

# Generate Interaction data (strong entity, 30-40 rows)
interactions = []
for i in range(1, 36):
    interactions.append({
        "InteractionID": i,
        "UserID": random.choice(user_list),
        "RecipeID": random.randint(1, 35),
        "InteractionType": random.choice(["Like", "Comment", "Share", "View"]),
        "Timestamp": fake.date_time_this_decade()
    })

interactions_df = pd.DataFrame(interactions)

# Generate LogEntry data (strong entity, 30-40 rows)
log_entries = []
for i in range(1, 36):
    log_entries.append({
        "LogID": i,
        "Timestamp": fake.date_time_this_decade(),
        "ErrorMessage": fake.sentence(6),
        "SeverityLevel": random.choice(["Low", "Medium", "High", "Critical"]),
        "Source": fake.domain_name(),
        "Details": fake.text(300)
    })

log_entries_df = pd.DataFrame(log_entries)

# Generate IssueReport data (strong entity, 30-40 rows)
issue_reports = []
for i in range(1, 36):
    issue_reports.append({
        "IssueID": i,
        "Reports": fake.text(200),
        "ReportedBy": fake.user_name(),
        "Description": fake.text(300),
        "Status": random.choice(["Open", "In Progress", "Resolved", "Closed"]),
        "Timestamp": fake.date_time_this_decade()
    })

issue_reports_df = pd.DataFrame(issue_reports)

# Generate LogEntry_IssueReport (bridge table, 125+ rows)
log_issue_links = []
for _ in range(150):
    log_issue_links.append({
        "LogID": random.randint(1, 35),
        "IssueID": random.randint(1, 35)
    })

log_issue_links_df = pd.DataFrame(log_issue_links).drop_duplicates(subset=["LogID", "IssueID"])

# Generate Alert data (strong entity, 30-40 rows)
alerts = []
for i in range(1, 36):
    alerts.append({
        "AlertID": i,
        "LogID": random.randint(1, 35),
        "AssignedTo": random.choice(user_list),
        "Timestamp": fake.date_time_this_decade(),
        "Type": random.choice(["System", "User", "Security", "Performance"]),
        "Status": random.choice(["New", "Acknowledged", "Resolved", "Dismissed"])
    })

alerts_df = pd.DataFrame(alerts)

# Save final CSVs
interactions_df.to_csv("database-files/Interaction.csv", index=False)
log_entries_df.to_csv("database-files/LogEntry.csv", index=False)
issue_reports_df.to_csv("database-files/IssueReport.csv", index=False)
log_issue_links_df.to_csv("database-files/LogEntry_IssueReport.csv", index=False)
alerts_df.to_csv("database-files/Alert.csv", index=False)

print("All CSV files generated successfully in database-files directory!")
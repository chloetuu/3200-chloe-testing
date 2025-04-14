import pandas as pd
import random
from datetime import datetime, timedelta

# Helper functions
def random_date(start, end):
    """Return a random date string between start and end."""
    delta = end - start
    random_days = random.randrange(delta.days)
    return (start + timedelta(days=random_days)).strftime("%Y-%m-%d")

def random_datetime(start, end):
    """Return a random datetime string between start and end."""
    delta = end - start
    random_seconds = random.randrange(int(delta.total_seconds()))
    return (start + timedelta(seconds=random_seconds)).strftime("%Y-%m-%d %H:%M:%S")

def random_bool():
    return random.choice([True, False])

def random_choice(options):
    return random.choice(options)

# Define some sample choices
first_names = ["John", "Alice", "Bruce", "Diana", "Clark", "Barry", "Hal", "Arthur"]
last_names = ["Doe", "Smith", "Wayne", "Prince", "Kent", "Allen", "Jordan", "Curry"]
regions = ["North", "South", "East", "West", "Central"]
activity_levels = ["Low", "Moderate", "Active"]
cuisines = ["Italian", "Mexican", "Indian", "Chinese", "American", "French", "Mediterranean"]
allergies = ["Gluten", "Dairy", "None", "Nuts", "Shellfish", "Soy"]
meal_types = ["Breakfast", "Lunch", "Dinner", "Snack"]
difficulties = ["Easy", "Medium", "Hard"]
interaction_types = ["Like", "Share", "Comment"]
severity_levels = ["Low", "Medium", "High"]
log_sources = ["DBConnector", "InputValidator", "AuthService", "APIHandler"]
alert_types = ["System", "Security", "Performance"]
alert_statuses = ["New", "Resolved", "In Progress"]
group_types = ["Age Group", "Income", "Location", "Interest"]
issue_statuses = ["Open", "In Progress", "Closed"]

# Date ranges for generating dates/datetimes
date_start = datetime(2020, 1, 1)
date_end = datetime(2024, 12, 31)
datetime_start = datetime(2020, 1, 1, 0, 0, 0)
datetime_end = datetime(2024, 12, 31, 23, 59, 59)

num_rows = 125

# --------------------------
# 1. Table: User
# --------------------------
users = []
for i in range(1, num_rows+1):
    username = f"user{i:03d}"
    first = random_choice(first_names)
    last = random_choice(last_names)
    region = random_choice(regions)
    activity = random_choice(activity_levels)
    age = random.randint(18, 70)
    inclusion = random_bool()
    bio = f"This is the bio of {first} {last}."
    users.append([username, first, last, region, activity, age, inclusion, bio])
users_df = pd.DataFrame(users, columns=["Username", "FirstName", "LastName", "Region", "ActivityLevel", "Age", "InclusionStatus", "Bio"])

# --------------------------
# 2. Table: Follows
# --------------------------
follows = []
for i in range(num_rows):
    follower = f"user{random.randint(1, num_rows):03d}"
    followee = f"user{random.randint(1, num_rows):03d}"
    # Ensure follower and followee are not the same:
    while followee == follower:
        followee = f"user{random.randint(1, num_rows):03d}"
    follow_date = random_date(date_start, date_end)
    follows.append([follower, followee, follow_date])
follows_df = pd.DataFrame(follows, columns=["follower_id", "followee_id", "follow_date"])

# --------------------------
# 3. Table: Tag
# --------------------------
tags = []
for i in range(1, num_rows+1):
    tag_id = i
    cuisine = random_choice(cuisines)
    allergy = random_choice(allergies)
    meal_type = random_choice(meal_types)
    tags.append([tag_id, cuisine, allergy, meal_type])
tag_df = pd.DataFrame(tags, columns=["TagID", "Cuisine", "Allergy", "MealType"])

# --------------------------
# 4. Table: Meal
# --------------------------
meals = []
for i in range(1, num_rows+1):
    recipe_id = i
    name = f"Meal {i}"
    date_created = random_date(date_start, date_end)
    prep_time = random.randint(5, 60)   # minutes
    cook_time = random.randint(5, 120)  # minutes
    # TotalTime is computed in DB but we need a placeholder text here.
    difficulty = random_choice(difficulties)
    ingredients = f"IngredientA, IngredientB, IngredientC"
    instructions = f"Step 1 for meal {i}; Step 2 for meal {i}."
    meals.append([recipe_id, name, date_created, prep_time, cook_time, difficulty, ingredients, instructions])
meal_df = pd.DataFrame(meals, columns=["RecipeID", "Name", "DateCreated", "PrepTime", "CookTime", "Difficulty", "Ingredients", "Instructions"])

# --------------------------
# 5. Table: Meal_Tag
# --------------------------
meal_tags = []
for i in range(num_rows):
    recipe_id = random.randint(1, num_rows)
    tag_id = random.randint(1, num_rows)
    meal_tags.append([recipe_id, tag_id])
meal_tag_df = pd.DataFrame(meal_tags, columns=["RecipeID", "TagID"])

# --------------------------
# 6. Table: Blog
# --------------------------
blogs = []
for i in range(1, num_rows+1):
    blog_id = i
    publish_date = random_datetime(datetime_start, datetime_end)
    content = f"This is the content of blog post {i}."
    title = f"Blog Title {i}"
    username = f"user{random.randint(1, num_rows):03d}"
    recipe_id = random.randint(1, num_rows)
    blogs.append([blog_id, publish_date, content, title, username, recipe_id])
blog_df = pd.DataFrame(blogs, columns=["BlogID", "PublishDate", "Content", "Title", "Username", "RecipeID"])

# --------------------------
# 7. Table: Blog_Meal
# --------------------------
blog_meals = []
for i in range(num_rows):
    blog_id = random.randint(1, num_rows)
    recipe_id = random.randint(1, num_rows)
    blog_meals.append([blog_id, recipe_id])
blog_meal_df = pd.DataFrame(blog_meals, columns=["BlogID", "RecipeID"])

# --------------------------
# 8. Table: Saved_Meals
# --------------------------
saved_meals = []
for i in range(num_rows):
    username = f"user{random.randint(1, num_rows):03d}"
    recipe_id = random.randint(1, num_rows)
    saved_meals.append([username, recipe_id])
saved_meals_df = pd.DataFrame(saved_meals, columns=["Username", "RecipeID"])

# --------------------------
# 9. Table: Added_Meals
# --------------------------
added_meals = []
for i in range(num_rows):
    username = f"user{random.randint(1, num_rows):03d}"
    recipe_id = random.randint(1, num_rows)
    added_meals.append([username, recipe_id])
added_meals_df = pd.DataFrame(added_meals, columns=["Username", "RecipeID"])

# --------------------------
# 10. Table: DemographicGroupData
# --------------------------
demo_groups = []
for i in range(1, num_rows+1):
    group_id = i
    group_type = random_choice(group_types)
    group_value = f"Value_{random.randint(1, 100)}"
    demo_groups.append([group_id, group_type, group_value])
demo_group_df = pd.DataFrame(demo_groups, columns=["GroupID", "GroupType", "GroupValue"])

# --------------------------
# 11. Table: UserDemographic
# --------------------------
user_demo = []
for i in range(num_rows):
    user_id = f"user{random.randint(1, num_rows):03d}"
    group_id = random.randint(1, num_rows)
    user_demo.append([user_id, group_id])
user_demo_df = pd.DataFrame(user_demo, columns=["UserID", "GroupID"])

# --------------------------
# 12. Table: CategoryData
# --------------------------
categories = []
for i in range(1, num_rows+1):
    category_id = i
    name = f"Category {i}"
    categories.append([category_id, name])
category_df = pd.DataFrame(categories, columns=["CategoryID", "Name"])

# --------------------------
# 13. Table: RecipeData
# --------------------------
recipe_data = []
for i in range(1, num_rows+1):
    recipe_id = i
    name = f"Recipe {i}"
    saved_status = random_bool()
    category_id = random.randint(1, num_rows)
    view_count = random.randint(0, 1000)
    recipe_data.append([recipe_id, name, saved_status, category_id, view_count])
recipe_data_df = pd.DataFrame(recipe_data, columns=["RecipeID", "Name", "SavedStatus", "CategoryID", "ViewCount"])

# --------------------------
# 14. Table: Interaction
# --------------------------
interactions = []
for i in range(1, num_rows+1):
    interaction_id = i
    user_id = f"user{random.randint(1, num_rows):03d}"
    recipe_id = random.randint(1, num_rows)
    interaction_type = random_choice(interaction_types)
    timestamp = random_datetime(datetime_start, datetime_end)
    interactions.append([interaction_id, user_id, recipe_id, interaction_type, timestamp])
interaction_df = pd.DataFrame(interactions, columns=["InteractionID", "UserID", "RecipeID", "InteractionType", "Timestamp"])

# --------------------------
# 15. Table: LogEntry
# --------------------------
log_entries = []
for i in range(1, num_rows+1):
    log_id = i
    timestamp = random_datetime(datetime_start, datetime_end)
    error_message = f"Error message {i}"
    severity = random_choice(severity_levels)
    source = random_choice(log_sources)
    details = f"Details for error {i}"
    log_entries.append([log_id, timestamp, error_message, severity, source, details])
log_entry_df = pd.DataFrame(log_entries, columns=["LogID", "Timestamp", "ErrorMessage", "SeverityLevel", "Source", "Details"])

# --------------------------
# 16. Table: IssueReport
# --------------------------
issue_reports = []
for i in range(1, num_rows+1):
    issue_id = i
    reports = f"Report info {i}"
    reported_by = f"user{random.randint(1, num_rows):03d}"
    description = f"Issue description {i}"
    status = random_choice(issue_statuses)
    timestamp = random_datetime(datetime_start, datetime_end)
    issue_reports.append([issue_id, reports, reported_by, description, status, timestamp])
issue_report_df = pd.DataFrame(issue_reports, columns=["IssueID", "Reports", "ReportedBy", "Description", "Status", "Timestamp"])

# --------------------------
# 17. Table: LogEntry_IssueReport
# --------------------------
log_issue = []
for i in range(num_rows):
    log_id = random.randint(1, num_rows)
    issue_id = random.randint(1, num_rows)
    log_issue.append([log_id, issue_id])
log_issue_df = pd.DataFrame(log_issue, columns=["LogID", "IssueID"])

# --------------------------
# 18. Table: Alert
# --------------------------
alerts = []
for i in range(1, num_rows+1):
    alert_id = i
    log_id = random.randint(1, num_rows)
    assigned_to = f"user{random.randint(1, num_rows):03d}"
    timestamp = random_datetime(datetime_start, datetime_end)
    a_type = random_choice(alert_types)
    status = random_choice(alert_statuses)
    alerts.append([alert_id, log_id, assigned_to, timestamp, a_type, status])
alert_df = pd.DataFrame(alerts, columns=["AlertID", "LogID", "AssignedTo", "Timestamp", "Type", "Status"])

# List of DataFrames and their target filenames
csv_files = {
    "User.csv": users_df,
    "Follows.csv": follows_df,
    "Tag.csv": tag_df,
    "Meal.csv": meal_df,
    "Meal_Tag.csv": meal_tag_df,
    "Blog.csv": blog_df,
    "Blog_Meal.csv": blog_meal_df,
    "Saved_Meals.csv": saved_meals_df,
    "Added_Meals.csv": added_meals_df,
    "DemographicGroupData.csv": demo_group_df,
    "UserDemographic.csv": user_demo_df,
    "CategoryData.csv": category_df,
    "RecipeData.csv": recipe_data_df,
    "Interaction.csv": interaction_df,
    "LogEntry.csv": log_entry_df,
    "IssueReport.csv": issue_report_df,
    "LogEntry_IssueReport.csv": log_issue_df,
    "Alert.csv": alert_df
}

# Save each DataFrame to a CSV file in /mnt/data
for filename, df in csv_files.items():
    file_path = f"database-files/{filename}"
    df.to_csv(file_path, index=False)
    print(f"Saved {filename} with {len(df)} rows")

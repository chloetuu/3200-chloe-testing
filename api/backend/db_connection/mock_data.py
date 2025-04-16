import csv
import os
import random
from datetime import datetime, timedelta
from faker import Faker

fake = Faker()

def generate_users(num_users=30):
    """Generate mock user data."""
    users = []
    for i in range(1, num_users + 1):
        users.append({
            'UserID': i,
            'Username': fake.user_name(),
            'Email': fake.email(),
            'Password': fake.password(),
            'FirstName': fake.first_name(),
            'LastName': fake.last_name(),
            'Age': random.randint(18, 80),
            'Gender': random.choice(['M', 'F', 'O']),
            'InclusionStatus': random.choice([True, False])
        })
    return users

def generate_meals(num_meals=30):
    """Generate mock meal data."""
    meals = []
    for i in range(1, num_meals + 1):
        prep_time = random.randint(10, 120)
        cook_time = random.randint(15, 180)
        meals.append({
            'MealID': i,
            'Name': fake.sentence(nb_words=3),
            'Description': fake.paragraph(),
            'PrepTime': prep_time,
            'CookTime': cook_time,
            'TotalTime': prep_time + cook_time,
            'Servings': random.randint(1, 8),
            'Difficulty': random.choice(['Easy', 'Medium', 'Hard']),
            'DateCreated': fake.date_time_this_year().strftime('%Y-%m-%d %H:%M:%S')
        })
    return meals

def generate_blogs(num_blogs=30):
    """Generate mock blog data."""
    blogs = []
    for i in range(1, num_blogs + 1):
        blogs.append({
            'BlogID': i,
            'Title': fake.sentence(nb_words=5),
            'Content': fake.paragraphs(nb=3),
            'PublishDate': fake.date_time_this_year().strftime('%Y-%m-%d %H:%M:%S'),
            'ViewCount': random.randint(0, 1000)
        })
    return blogs

def generate_categories(num_categories=30):
    """Generate mock category data."""
    categories = []
    cuisine_types = ['Italian', 'Mexican', 'Chinese', 'Indian', 'Japanese', 'American', 'Mediterranean', 
                    'Thai', 'Vietnamese', 'French', 'Greek', 'Spanish', 'Korean', 'Middle Eastern', 'Caribbean']
    for i in range(1, num_categories + 1):
        categories.append({
            'CategoryID': i,
            'Name': random.choice(cuisine_types),
            'Description': fake.sentence()
        })
    return categories

def generate_groups(num_groups=30):
    """Generate mock group data."""
    groups = []
    group_types = ['Vegetarian', 'Vegan', 'Gluten-Free', 'Dairy-Free', 'Keto', 'Paleo', 'Low-Carb', 
                  'High-Protein', 'Mediterranean', 'Quick Meals', 'Gourmet', 'Budget-Friendly', 
                  'Family-Friendly', 'Healthy Eating', 'Meal Prep']
    for i in range(1, num_groups + 1):
        groups.append({
            'GroupID': i,
            'Name': random.choice(group_types),
            'Description': fake.paragraph(),
            'CreatedDate': fake.date_time_this_year().strftime('%Y-%m-%d %H:%M:%S')
        })
    return groups

def generate_follows(users, num_follows=30):
    """Generate mock follow data."""
    follows = []
    for _ in range(num_follows):
        follower = random.choice(users)
        followed = random.choice(users)
        while follower['UserID'] == followed['UserID']:
            followed = random.choice(users)
        follows.append({
            'FollowerID': follower['UserID'],
            'FollowedID': followed['UserID'],
            'follow_date': fake.date_time_this_year().strftime('%Y-%m-%d %H:%M:%S')
        })
    return follows

def generate_saves(users, meals, num_saves=30):
    """Generate mock save data."""
    saves = []
    for _ in range(num_saves):
        saves.append({
            'UserID': random.choice(users)['UserID'],
            'MealID': random.choice(meals)['MealID'],
            'SavedStatus': random.choice([True, False])
        })
    return saves

def generate_logs(num_logs=30):
    """Generate mock log data."""
    logs = []
    for i in range(1, num_logs + 1):
        logs.append({
            'LogID': i,
            'Timestamp': fake.date_time_this_year().strftime('%Y-%m-%d %H:%M:%S'),
            'ErrorMessage': fake.sentence(),
            'SeverityLevel': random.choice(['INFO', 'WARNING', 'ERROR', 'CRITICAL']),
            'Source': fake.word(),
            'Details': fake.paragraph()
        })
    return logs

def generate_alerts(num_alerts=30):
    """Generate mock alert data."""
    alerts = []
    for i in range(1, num_alerts + 1):
        alerts.append({
            'AlertID': i,
            'Message': fake.sentence(),
            'Severity': random.choice(['LOW', 'MEDIUM', 'HIGH', 'CRITICAL']),
            'Timestamp': fake.date_time_this_year().strftime('%Y-%m-%d %H:%M:%S')
        })
    return alerts

def generate_issues(num_issues=30):
    """Generate mock issue data."""
    issues = []
    for i in range(1, num_issues + 1):
        issues.append({
            'IssueID': i,
            'Title': fake.sentence(),
            'Description': fake.paragraph(),
            'Status': random.choice(['OPEN', 'IN_PROGRESS', 'RESOLVED', 'CLOSED']),
            'Priority': random.choice(['LOW', 'MEDIUM', 'HIGH', 'CRITICAL']),
            'CreatedDate': fake.date_time_this_year().strftime('%Y-%m-%d %H:%M:%S')
        })
    return issues

def write_to_csv(data, filename):
    """Write data to CSV file."""
    if not data:
        return
    
    with open(f'database-files/csv/{filename}', 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)

def main():
    # Create CSV directory if it doesn't exist
    os.makedirs('database-files/csv', exist_ok=True)
    
    # Generate and write data for each table
    users = generate_users()
    write_to_csv(users, 'User.csv')
    
    meals = generate_meals()
    write_to_csv(meals, 'Meal.csv')
    
    blogs = generate_blogs()
    write_to_csv(blogs, 'Blog.csv')
    
    categories = generate_categories()
    write_to_csv(categories, 'Category.csv')
    
    groups = generate_groups()
    write_to_csv(groups, 'Group.csv')
    
    follows = generate_follows(users)
    write_to_csv(follows, 'Follow.csv')
    
    saves = generate_saves(users, meals)
    write_to_csv(saves, 'Save.csv')
    
    logs = generate_logs()
    write_to_csv(logs, 'LogEntry.csv')
    
    alerts = generate_alerts()
    write_to_csv(alerts, 'Alert.csv')
    
    issues = generate_issues()
    write_to_csv(issues, 'Issue.csv')

if __name__ == "__main__":
    main() 
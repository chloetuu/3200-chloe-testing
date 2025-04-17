########################################################
# Sample favorites blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################

from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db
import logging

favorites = Blueprint('favorites', __name__)

@favorites.route('/favorites', methods=['GET'])
def get_favorite_meals():
    cursor = db.get_db().cursor()
    username = request.args.get('username')
    current_app.logger.info(f'GET /favorites called with username: {username}')

    if not username:
        return make_response(jsonify({"error": "Username parameter is required"}), 400)

    # First, check if there are any saved meals for this user
    check_query = '''
        SELECT COUNT(*) as count
        FROM Saved_Meals
        WHERE LOWER(Username) = LOWER(%s)
    '''
    cursor.execute(check_query, (username,))
    count_result = cursor.fetchone()
    current_app.logger.info(f'Found {count_result["count"]} saved meals for user {username}')

    query = '''
        SELECT m.*
        FROM Saved_Meals s
        JOIN Meal m ON s.RecipeID = m.RecipeID
        WHERE LOWER(s.Username) = LOWER(%s)
    '''
    cursor.execute(query, (username,))
    result = cursor.fetchall()
    current_app.logger.info(f'Retrieved {len(result)} meals with details for user {username}')

    response = make_response(jsonify(result))
    response.status_code = 200
    response.mimetype = 'application/json'
    return response

@favorites.route('/favorites', methods=['POST'])
def add_favorite():
    current_app.logger.info('POST /favorites route called')
    fav_info = request.json
    username = fav_info['username']
    recipe_id = fav_info['recipe_id']

    # First, ensure the user exists in the User table
    cursor = db.get_db().cursor()
    try:
        # Check if user exists
        check_user_query = '''
            SELECT Username FROM User WHERE LOWER(Username) = LOWER(%s)
        '''
        cursor.execute(check_user_query, (username,))
        user_exists = cursor.fetchone()

        if not user_exists:
            # Create the user if they don't exist
            insert_user_query = '''
                INSERT INTO User (Username, FirstName, LastName, Region, ActivityLevel, Age, Bio)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            '''
            cursor.execute(insert_user_query, (
                username,
                username.capitalize(),  # FirstName
                'User',  # LastName
                'Unknown',  # Region
                'Medium',  # ActivityLevel
                30,  # Age
                'A user of the Tummy app'  # Bio
            ))
            db.get_db().commit()
            current_app.logger.info(f'Created new user: {username}')

        # Check if the meal is already favorited
        check_favorite_query = '''
            SELECT RecipeID FROM Saved_Meals 
            WHERE Username = %s AND RecipeID = %s
        '''
        cursor.execute(check_favorite_query, (username, recipe_id))
        already_favorited = cursor.fetchone()

        if already_favorited:
            current_app.logger.info(f'Meal {recipe_id} is already favorited by {username}')
            return jsonify({'message': 'This meal is already in your favorites!'}), 200

        # Now add the meal to favorites
        query = '''
            INSERT INTO Saved_Meals (Username, RecipeID)
            VALUES (%s, %s)
        '''
        cursor.execute(query, (username, recipe_id))
        db.get_db().commit()
        current_app.logger.info(f'Added meal {recipe_id} to favorites for user {username}')

        return jsonify({'message': 'Meal added to favorites!'}), 201
    except Exception as e:
        current_app.logger.error(f'Error in add_favorite: {str(e)}')
        return jsonify({'error': str(e)}), 500

@favorites.route('/favorites/check', methods=['GET'])
def check_saved_meals():
    cursor = db.get_db().cursor()
    current_app.logger.info('GET /favorites/check called')
    
    # Get all saved meals
    query = '''
        SELECT s.Username, s.RecipeID, m.Name as MealName
        FROM Saved_Meals s
        JOIN Meal m ON s.RecipeID = m.RecipeID
    '''
    cursor.execute(query)
    result = cursor.fetchall()
    current_app.logger.info(f'Found {len(result)} total saved meals')
    
    # Group by username
    meals_by_user = {}
    for row in result:
        username = row['Username']
        if username not in meals_by_user:
            meals_by_user[username] = []
        meals_by_user[username].append({
            'RecipeID': row['RecipeID'],
            'MealName': row['MealName']
        })
    
    current_app.logger.info(f'Saved meals by user: {meals_by_user}')
    return jsonify(meals_by_user)

@favorites.route('/favorites/debug', methods=['GET'])
def debug_saved_meals():
    cursor = db.get_db().cursor()
    current_app.logger.info('GET /favorites/debug called')
    
    # Get all saved meals
    query = '''
        SELECT s.Username, s.RecipeID, m.Name as MealName
        FROM Saved_Meals s
        JOIN Meal m ON s.RecipeID = m.RecipeID
    '''
    cursor.execute(query)
    result = cursor.fetchall()
    current_app.logger.info(f'Found {len(result)} total saved meals')
    
    # Group by username
    meals_by_user = {}
    for row in result:
        username = row['Username']
        if username not in meals_by_user:
            meals_by_user[username] = []
        meals_by_user[username].append({
            'RecipeID': row['RecipeID'],
            'MealName': row['MealName']
        })
    
    current_app.logger.info(f'Saved meals by user: {meals_by_user}')
    return jsonify(meals_by_user)

# Initialize test data for Nina
@favorites.route('/favorites/init', methods=['POST'])
def init_favorites():
    cursor = db.get_db().cursor()
    current_app.logger.info('POST /favorites/init called')
    
    try:
        # Get some meal IDs from the Meal table
        cursor.execute('SELECT RecipeID FROM Meal LIMIT 5')
        meal_ids = [row['RecipeID'] for row in cursor.fetchall()]
        current_app.logger.info(f'Found {len(meal_ids)} meal IDs: {meal_ids}')
        
        # Add these meals to Nina's saved meals
        for meal_id in meal_ids:
            query = 'INSERT IGNORE INTO Saved_Meals (Username, RecipeID) VALUES (%s, %s)'
            cursor.execute(query, ('nina', meal_id))
            current_app.logger.info(f'Added meal {meal_id} to Nina\'s saved meals')
        
        db.get_db().commit()
        current_app.logger.info('Successfully initialized test data for Nina')
        return jsonify({'message': 'Test data initialized successfully'})
    except Exception as e:
        current_app.logger.error(f'Error initializing test data: {str(e)}')
        return jsonify({'error': str(e)}), 500

# Deletes a favorited meal
@favorites.route('/favorites/<int:recipe_id>', methods=['DELETE'])
def delete_favorite(recipe_id):
    try:
        username = request.args.get('username')
        if not username:
            return jsonify({'error': 'Username is required'}), 400
            
        logging.info(f"Attempting to delete favorite meal {recipe_id} for user {username}")
        
        # Delete the favorite meal
        cursor = db.get_db().cursor()
        cursor.execute(
            "DELETE FROM Saved_Meals WHERE Username = %s AND RecipeID = %s",
            (username, recipe_id)
        )
        db.get_db().commit()
        cursor.close()
        
        logging.info(f"Successfully deleted favorite meal {recipe_id} for user {username}")
        return jsonify({'message': 'Favorite meal deleted successfully'}), 200
        
    except Exception as e:
        logging.error(f"Error deleting favorite meal: {str(e)}")
        return jsonify({'error': str(e)}), 500

@favorites.route('/james/engagement_over_time', methods=['GET'])
def get_engagement_over_time():
    cursor = db.get_db().cursor()
    current_app.logger.info('GET /james/engagement_over_time called')
    
    try:
        query = '''
            SELECT DATE(Timestamp) AS SaveDate, COUNT(*) AS SaveCount
            FROM Saved_Meals
            GROUP BY SaveDate
            ORDER BY SaveDate ASC
        '''
        cursor.execute(query)
        result = cursor.fetchall()

        response = make_response(jsonify(result))
        response.status_code = 200
        response.mimetype = 'application/json'
        return response
    except Exception as e:
        current_app.logger.error(f'Error retrieving engagement data: {str(e)}')
        return jsonify({'error': str(e)}), 500

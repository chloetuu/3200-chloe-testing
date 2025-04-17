from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db

meals = Blueprint('meals', __name__)

# Get all meals
@meals.route('/meals', methods=['GET'])
def get_all_meals():
    cursor = db.get_db().cursor()
    query = '''
        SELECT m.*, GROUP_CONCAT(t.TagName) as Tags
        FROM Meal m
        LEFT JOIN Meal_Tag mt ON m.RecipeID = mt.RecipeID
        LEFT JOIN Tag t ON mt.TagID = t.TagID
        GROUP BY m.RecipeID
    '''
    cursor.execute(query)
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    response.mimetype = 'application/json'
    return response

# Add a new meal
@meals.route('/meals', methods=['POST'])
def add_meal():
    current_app.logger.info('POST /meals route called')
    meal_info = request.json

    name = meal_info['name']
    prep_time = meal_info['prep_time']
    cook_time = meal_info['cook_time']
    total_time = prep_time + cook_time
    difficulty = meal_info['difficulty']
    ingredients = meal_info['ingredients']
    instructions = meal_info['instructions']
    tags = meal_info.get('tags', [])   

    cursor = db.get_db().cursor()
    try:
        # Insert into Meal table
        query = '''
            INSERT INTO Meal (Name, DateCreated, PrepTime, CookTime, TotalTime, 
                            Difficulty, Ingredients, Instructions, ViewCount)
            VALUES (%s, CURDATE(), %s, %s, %s, %s, %s, %s, 0)
        '''
        data = (name, prep_time, cook_time, total_time, difficulty, ingredients, instructions)
        cursor.execute(query, data)
        recipe_id = cursor.lastrowid

        # Add tags if provided
        if tags:
            # Get or create tags
            for tag_name in tags:
                # Check if tag exists
                cursor.execute('SELECT TagID FROM Tag WHERE TagName = %s', (tag_name,))
                result = cursor.fetchone()
                if result:
                    tag_id = result['TagID']
                else:
                    # Create new tag
                    cursor.execute('INSERT INTO Tag (TagName) VALUES (%s)', (tag_name,))
                    tag_id = cursor.lastrowid
                
                # Link tag to meal
                cursor.execute('INSERT INTO Meal_Tag (RecipeID, TagID) VALUES (%s, %s)', 
                             (recipe_id, tag_id))

        db.get_db().commit()
        return jsonify({'message': 'Meal added successfully!', 'recipe_id': recipe_id}), 201
    except Exception as e:
        db.get_db().rollback()
        current_app.logger.error(f'Error adding meal: {str(e)}')
        return jsonify({'error': str(e)}), 500

# Delete a meal by RecipeID
@meals.route('/meals/<int:recipe_id>', methods=['DELETE'])
def delete_meal(recipe_id):
    current_app.logger.info(f'DELETE /meals/{recipe_id} route called')
    cursor = db.get_db().cursor()
    
    try:
        # Delete from Meal_Tag first (foreign key constraint)
        cursor.execute('DELETE FROM Meal_Tag WHERE RecipeID = %s', (recipe_id,))
        
        # Delete from Meal
        cursor.execute('DELETE FROM Meal WHERE RecipeID = %s', (recipe_id,))
        
        db.get_db().commit()
        return jsonify({'message': 'Meal deleted successfully!'}), 200
    except Exception as e:
        db.get_db().rollback()
        current_app.logger.error(f'Error deleting meal: {str(e)}')
        return jsonify({'error': str(e)}), 500

@meals.route('/meals/init', methods=['POST'])
def init_meals():
    cursor = db.get_db().cursor()
    current_app.logger.info('POST /meals/init called')
    
    try:
        # Initialize some test meals with tags
        test_meals = [
            {
                'name': 'Acai Smoothie Bowl',
                'prep_time': 10,
                'cook_time': 0,
                'difficulty': 'Easy',
                'ingredients': 'Acai puree; Granola; Banana; Berries; Honey',
                'instructions': 'Blend acai puree. Top with granola, banana, berries, and honey.',
                'tags': ['Healthy', 'Vegetarian', 'Quick']
            },
            {
                'name': 'Tiramisu Cake',
                'prep_time': 30,
                'cook_time': 0,
                'difficulty': 'Medium',
                'ingredients': 'Ladyfingers; Coffee; Mascarpone; Eggs; Sugar; Cocoa powder',
                'instructions': 'Dip ladyfingers in coffee. Layer with mascarpone mixture. Dust with cocoa.',
                'tags': ['Dessert', 'Italian', 'No-Cook']
            },
            {
                'name': 'Steak & Eggs',
                'prep_time': 15,
                'cook_time': 20,
                'difficulty': 'Medium',
                'ingredients': 'Ribeye steak; Eggs; Butter; Salt; Pepper',
                'instructions': 'Season and cook steak to desired doneness. Fry eggs. Serve together.',
                'tags': ['High-Protein', 'Breakfast', 'Low-Carb']
            }
        ]
        
        for meal in test_meals:
            # Insert into Meal table
            cursor.execute('''
                INSERT INTO Meal (Name, DateCreated, PrepTime, CookTime, TotalTime,
                                Difficulty, Ingredients, Instructions, ViewCount)
                VALUES (%s, CURDATE(), %s, %s, %s, %s, %s, %s, 0)
            ''', (
                meal['name'], meal['prep_time'], meal['cook_time'],
                meal['prep_time'] + meal['cook_time'],
                meal['difficulty'], meal['ingredients'], meal['instructions']
            ))
            
            recipe_id = cursor.lastrowid
            
            # Add tags
            for tag_name in meal['tags']:
                # Check if tag exists
                cursor.execute('SELECT TagID FROM Tag WHERE TagName = %s', (tag_name,))
                result = cursor.fetchone()
                if result:
                    tag_id = result['TagID']
                else:
                    # Create new tag
                    cursor.execute('INSERT INTO Tag (TagName) VALUES (%s)', (tag_name,))
                    tag_id = cursor.lastrowid
                
                # Link tag to meal
                cursor.execute('INSERT INTO Meal_Tag (RecipeID, TagID) VALUES (%s, %s)', 
                             (recipe_id, tag_id))
        
        db.get_db().commit()
        current_app.logger.info('Successfully initialized test data for meals')
        return jsonify({'message': 'Test meals initialized successfully'})
    except Exception as e:
        db.get_db().rollback()
        current_app.logger.error(f'Error initializing test meals: {str(e)}')
        return jsonify({'error': str(e)}), 500

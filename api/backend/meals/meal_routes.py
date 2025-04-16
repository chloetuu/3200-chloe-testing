from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db

meals = Blueprint('meals', __name__)

# Get all meals
@meals.route('/meals', methods=['GET'])
def get_all_meals():
    cursor = db.get_db().cursor()
    query = '''
        SELECT m.*, c.Name as Category
        FROM Meal m
        LEFT JOIN RecipeData r ON m.RecipeID = r.RecipeID
        LEFT JOIN CategoryData c ON r.CategoryID = c.CategoryID
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

    recipe_id = meal_info['recipe_id']  # must be passed in explicitly
    name = meal_info['name']
    prep_time = meal_info['prep_time']
    cook_time = meal_info['cook_time']
    difficulty = meal_info['difficulty']
    ingredients = meal_info['ingredients']
    instructions = meal_info['instructions']

    query = '''
        INSERT INTO Meal (RecipeID, Name, PrepTime, CookTime, Difficulty, Ingredients, Instructions)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    '''
    data = (recipe_id, name, prep_time, cook_time, difficulty, ingredients, instructions)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return 'Meal added successfully!', 201

# Delete a meal by RecipeID
@meals.route('/meals/<int:recipe_id>', methods=['DELETE'])
def delete_meal(recipe_id):
    current_app.logger.info(f'DELETE /meals/{recipe_id} route called')

    query = '''
        DELETE FROM Meal WHERE RecipeID = %s
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query, (recipe_id,))
    db.get_db().commit()

    return 'Meal deleted successfully!', 200

@meals.route('/meals/init', methods=['POST'])
def init_meals():
    cursor = db.get_db().cursor()
    current_app.logger.info('POST /meals/init called')
    
    try:
        # Get category IDs
        cursor.execute('SELECT CategoryID, Name FROM CategoryData')
        category_map = {row['Name']: row['CategoryID'] for row in cursor.fetchall()}
        
        # Initialize some test meals with categories
        test_meals = [
            {
                'name': 'Acai Smoothie Bowl',
                'prep_time': 10,
                'cook_time': 0,
                'difficulty': 'Easy',
                'ingredients': 'Acai puree; Granola; Banana; Berries; Honey',
                'instructions': 'Blend acai puree. Top with granola, banana, berries, and honey.',
                'category': 'Breakfast'
            },
            {
                'name': 'Tiramisu Cake',
                'prep_time': 30,
                'cook_time': 0,
                'difficulty': 'Medium',
                'ingredients': 'Ladyfingers; Coffee; Mascarpone; Eggs; Sugar; Cocoa powder',
                'instructions': 'Dip ladyfingers in coffee. Layer with mascarpone mixture. Dust with cocoa.',
                'category': 'Desserts'
            },
            {
                'name': 'Steak & Eggs',
                'prep_time': 15,
                'cook_time': 20,
                'difficulty': 'Medium',
                'ingredients': 'Ribeye steak; Eggs; Butter; Salt; Pepper',
                'instructions': 'Season and cook steak to desired doneness. Fry eggs. Serve together.',
                'category': 'Breakfast'
            }
        ]
        
        for meal in test_meals:
            # Insert into Meal table
            cursor.execute('''
                INSERT INTO Meal (Name, PrepTime, CookTime, Difficulty, Ingredients, Instructions)
                VALUES (%s, %s, %s, %s, %s, %s)
            ''', (
                meal['name'], meal['prep_time'], meal['cook_time'],
                meal['difficulty'], meal['ingredients'], meal['instructions']
            ))
            
            # Get the RecipeID of the inserted meal
            recipe_id = cursor.lastrowid
            
            # Insert into RecipeData table with category
            cursor.execute('''
                INSERT INTO RecipeData (RecipeID, Name, SavedStatus, CategoryID, ViewCount)
                VALUES (%s, %s, %s, %s, %s)
            ''', (
                recipe_id, meal['name'], 0,
                category_map[meal['category']], 0
            ))
        
        db.get_db().commit()
        current_app.logger.info('Successfully initialized test data for meals')
        return jsonify({'message': 'Test meals initialized successfully'})
    except Exception as e:
        current_app.logger.error(f'Error initializing test meals: {str(e)}')
        return jsonify({'error': str(e)}), 500

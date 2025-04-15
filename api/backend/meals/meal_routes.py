from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db

meals = Blueprint('meals', __name__)

# Get all meals
@meals.route('/meals', methods=['GET'])
def get_all_meals():
    cursor = db.get_db().cursor()
    query = '''
        SELECT * FROM Meal
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

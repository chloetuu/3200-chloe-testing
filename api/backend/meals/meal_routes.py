########################################################
# Sample users blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict

meals = Blueprint('meals', __name__ )

# Gets all meals 
@meals.route('/meals', methods=['GET'])
def get_all_meals():
    cursor = db.get_db().cursor()
    the_query = '''
    SELECT Username, MealName, Calories, MealTime, Notes
    FROM Meals
'''
    cursor.execute(the_query)
    theData = cursor.fetchall()
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200 
    the_response.mimetype='application/json'
    return the_response

# Adds a meal 
@meals.route('/meals', methods=['POST'])
def add_meal():
    current_app.logger.info('POST /meals route')
    meal_info = request.json
    username = meal_info['username']
    meal_name = meal_info['meal_name']
    calories = meal_info['calories']
    meal_time = meal_info['meal_time']
    notes = meal_info.get('notes', '')  

    query = '''INSERT INTO Meals (Username, MealName, Calories, MealTime, Notes)
               VALUES (%s, %s, %s, %s, %s)'''
    data = (username, meal_name, calories, meal_time, notes)
    
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return jsonify(theData)

# Deletes a meal 
@meals.route('/meals/<int:recipe_id>', methods=['DELETE'])
def delete_meal(recipe_id):
    current_app.logger.info(f'DELETE /meals/{recipe_id} route called')

    query = '''DELETE FROM Meal WHERE RecipeID = %s'''
    cursor = db.get_db().cursor()
    cursor.execute(query, (recipe_id,))
    db.get_db().commit()
    
    return 'Meal deleted!'

@meals.route('/top-recipes', methods=['GET'])
def get_top_recipes():
    cursor = db.get_db().cursor()
    query = '''
        SELECT RecipeID, Title, Category, Views, Saves
        FROM Recipes
        ORDER BY Views DESC
        LIMIT 4
    '''
    cursor.execute(query)
    data = cursor.fetchall()
    return jsonify(data)

@meals.route('/flagged-recipes', methods=['GET'])
def get_flagged_recipes():
    cursor = db.get_db().cursor()
    query = '''
        SELECT RecipeID, Title, Category, Views, Saves, Flagged
        FROM Recipes
        WHERE Flagged = TRUE
    '''
    cursor.execute(query)
    data = cursor.fetchall()
    return jsonify(data)

@meals.route('/recipes/<int:recipe_id>', methods=['PUT'])
def update_recipe(recipe_id):
    recipe_info = request.json
    title = recipe_info['title']
    category = recipe_info['category']
    views = recipe_info['views']
    saves = recipe_info['saves']
    flagged = recipe_info['flagged']

    query = '''
        UPDATE Recipes
        SET Title = %s, Category = %s, Views = %s, Saves = %s, Flagged = %s
        WHERE RecipeID = %s
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query, (title, category, views, saves, flagged, recipe_id))
    db.get_db().commit()

    return jsonify({"message": "Recipe updated successfully"})



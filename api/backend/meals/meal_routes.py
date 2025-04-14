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

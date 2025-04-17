from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

blogs = Blueprint('/blogs', __name__ )

# Gets all blogs 
@blogs.route('/blogs', methods=['GET'])
def get_all_blogs():
    cursor = db.get_db().cursor()
    the_query = '''
    SELECT *
    FROM Blog
'''
    cursor.execute(the_query)
    data = cursor.fetchall()
    the_response = make_response(jsonify(data))
    the_response.status_code = 200 
    the_response.mimetype='application/json'
    return the_response

# Adds a blog
@blogs.route('/blogs', methods=['POST'])
def add_blog():
    current_app.logger.info('POST /blogs route')
    meal_info = request.json
    username = meal_info['username']
    meal_name = meal_info['meal_name']
    calories = meal_info['calories']
    meal_time = meal_info['meal_time']
    notes = meal_info.get('notes', '')  

    query = '''INSERT INTO Blog (Username, MealName, Calories, MealTime, Notes)
               VALUES (%s, %s, %s, %s, %s)'''
    data = (username, meal_name, calories, meal_time, notes)
    
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return 'Meal(s) added!'


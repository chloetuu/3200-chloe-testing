from flask import Blueprint, request, jsonify, make_response, current_app 
from backend.db_connection import db
from backend.ml_models.model01 import predict 

users = Blueprint('recipes' , __name__)

@recipes.route('/recipes', methods = ['GET'])
def get_all_recipes():
    cursor = db.get_db().cursor()
    the_query = '''
    SELECT Recipe_ID, Name, Saved_Status, Category_ID, View_Count
    FROM Recipes
    '''

    cursor.execute(the_query)
    theData = cursor.fetchall()
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200 
    the_response.mimetype = 'application/json'
    return the_response


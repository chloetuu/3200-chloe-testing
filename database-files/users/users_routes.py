from flask import Blueprint, request, jsonify, make_response, current_app 
from backend.db_connection import db
from backend.ml_models.model01 import predict 

users = Blueprint('users' , __name__)

@users.route('/users', methods = ['GET'])
def get_all_users():
    cursor = db.get_db().cursor()
    the_query = '''
    SELECT Username, FirstName, LastName, Region, ActivityLevel, Age, InclusionStatus, Bio
    FROM User 
    '''

    cursor.execute(the_query)
    theData = cursor.fetchall()
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200 
    the_response.mimetype = 'application/json'
    return the_response
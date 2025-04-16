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

@users.route('/users', methods=['POST'])
def add_user():
    # Get the data from the request
    user_data = request.get_json()

    required_fields = ['Username', 'FirstName', 'LastName', 'Region', 'ActivityLevel', 'Age', 'InclusionStatus', 'Bio']
    if not all(field in user_data for field in required_fields):
        return make_response(jsonify({'error': 'Missing required user data'}), 400)

    # Get the DB cursor
    db_connection = db.get_db()
    cursor = db_connection.cursor()

    # Insert the new user
    insert_query = '''
        INSERT INTO User (Username, FirstName, LastName, Region, ActivityLevel, Age, InclusionStatus, Bio)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    '''
    values = (
        user_data['Username'],
        user_data['FirstName'],
        user_data['LastName'],
        user_data['Region'],
        user_data['ActivityLevel'],
        user_data['Age'],
        user_data['InclusionStatus'],
        user_data['Bio']
    )

    try:
        cursor.execute(insert_query, values)
        db_connection.commit()
        return make_response(jsonify({'message': 'User added successfully'}), 201)
    except Exception as e:
        current_app.logger.error(f"Failed to add user: {e}")
        return make_response(jsonify({'error': 'Failed to add user'}), 500)

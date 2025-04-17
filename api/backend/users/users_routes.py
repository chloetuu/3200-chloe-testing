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

@users.route('/users/analytics', methods=['GET'])
def get_user_analytics():
    current_app.logger.info('GET /users/analytics called')
    cursor = db.get_db().cursor()

    try:
        # 1. Region distribution
        cursor.execute('''
            SELECT Region, COUNT(*) AS count
            FROM User
            GROUP BY Region
        ''')
        region_counts = cursor.fetchall()

        # 2. Activity level distribution
        cursor.execute('''
            SELECT ActivityLevel, COUNT(*) AS count
            FROM User
            GROUP BY ActivityLevel
        ''')
        activity_counts = cursor.fetchall()

        # 3. Age distribution
        cursor.execute('''
            SELECT 
                CASE 
                    WHEN Age < 18 THEN 'Under 18'
                    WHEN Age BETWEEN 18 AND 24 THEN '18-24'
                    WHEN Age BETWEEN 25 AND 34 THEN '25-34'
                    WHEN Age BETWEEN 35 AND 44 THEN '35-44'
                    WHEN Age BETWEEN 45 AND 54 THEN '45-54'
                    WHEN Age BETWEEN 55 AND 64 THEN '55-64'
                    ELSE '65+'
                END as age_group,
                COUNT(*) as count
            FROM User
            GROUP BY age_group
            ORDER BY MIN(Age)
        ''')
        age_distribution = cursor.fetchall()

        return jsonify({
            'data': {
                'region_counts': region_counts,
                'activity_counts': activity_counts,
                'age_distribution': age_distribution
            }
        }), 200

    except Exception as e:
        current_app.logger.error(f'Error in /users/analytics: {str(e)}')
        return jsonify({'error': str(e)}), 500

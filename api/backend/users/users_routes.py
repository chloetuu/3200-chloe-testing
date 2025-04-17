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

@users.route('/users/follows', methods=['GET'])
def get_all_follow_counts():
    cursor = db.get_db().cursor()
    current_app.logger.info('GET /users/follows called')
    
    query = '''
    SELECT 
        u.Username,
        (SELECT COUNT(*) FROM Follows WHERE FolloweeUsername = u.Username) as follower_count,
        (SELECT COUNT(*) FROM Follows WHERE FollowerUsername = u.Username) as following_count
    FROM User u
    '''
    
    cursor.execute(query)
    follow_counts = cursor.fetchall()
    current_app.logger.info(f'Found follow counts for {len(follow_counts)} users')
    
    return jsonify(follow_counts)

@users.route('/users/<username>/followers', methods=['GET'])
def get_follower_count(username):
    cursor = db.get_db().cursor()
    current_app.logger.info(f'GET /users/{username}/followers called')
    
    query = '''
    SELECT COUNT(*) as follower_count
    FROM Follows
    WHERE FolloweeUsername = %s
    '''
    
    cursor.execute(query, (username,))
    count = cursor.fetchone()['follower_count']
    current_app.logger.info(f'Found {count} followers for user {username}')
    
    return jsonify({'follower_count': count})

@users.route('/users/<username>/following', methods=['GET'])
def get_following_count(username):
    cursor = db.get_db().cursor()
    current_app.logger.info(f'GET /users/{username}/following called')
    
    query = '''
    SELECT COUNT(*) as following_count
    FROM Follows
    WHERE FollowerUsername = %s
    '''
    
    cursor.execute(query, (username,))
    count = cursor.fetchone()['following_count']
    current_app.logger.info(f'Found {count} following for user {username}')
    
    return jsonify({'following_count': count})

@users.route('/users/<username>/firstname', methods=['GET'])
def get_user_firstname(username):
    cursor = db.get_db().cursor()
    the_query = '''
    SELECT FirstName
    FROM User 
    WHERE LOWER(Username) = LOWER(%s)
    '''
    cursor.execute(the_query, (username,))
    result = cursor.fetchone()
    
    if result:
        the_response = make_response(jsonify({'first_name': result['FirstName']}))
        the_response.status_code = 200
    else:
        the_response = make_response(jsonify({'error': 'User not found'}), 404)
    
    the_response.mimetype = 'application/json'
    return the_response

@users.route('/users/<username>/bio', methods=['GET'])
def get_user_bio(username):
    cursor = db.get_db().cursor()
    the_query = '''
    SELECT Bio
    FROM User 
    WHERE LOWER(Username) = LOWER(%s)
    '''
    cursor.execute(the_query, (username,))
    result = cursor.fetchone()
    
    if result:
        the_response = make_response(jsonify({'bio': result['Bio']}))
        the_response.status_code = 200
    else:
        the_response = make_response(jsonify({'error': 'User not found'}), 404)
    
    the_response.mimetype = 'application/json'
    return the_response

@users.route('/users/analytics/behavior', methods=['GET'])
def get_user_behavior():
    cursor = db.get_db().cursor()
    days = request.args.get('days', '7')  # Default to 7 days
    
    query = '''
    SELECT 
        DATE(Timestamp) as date,
        COUNT(CASE WHEN ActionType = 'ADD' THEN 1 END) as added_count,
        COUNT(CASE WHEN ActionType = 'SAVE' THEN 1 END) as saved_count
    FROM UserAction
    WHERE Timestamp >= DATE_SUB(CURRENT_DATE, INTERVAL %s DAY)
    GROUP BY DATE(Timestamp)
    ORDER BY date
    '''
    
    try:
        cursor.execute(query, (days,))
        data = cursor.fetchall()
        return jsonify({'data': data})
    except Exception as e:
        current_app.logger.error(f'Error fetching user behavior: {str(e)}')
        return jsonify({'error': str(e)}), 500

@users.route('/users/demographics/groups', methods=['GET'])
def get_demographic_groups():
    cursor = db.get_db().cursor()
    
    query = '''
    SELECT DISTINCT 
        CASE 
            WHEN GroupType = 'AGE' THEN CONCAT('age: ', GroupValue)
            WHEN GroupType = 'REGION' THEN CONCAT('region: ', GroupValue)
            ELSE CONCAT(GroupType, ': ', GroupValue)
        END as group_name,
        GroupType,
        GroupValue,
        COUNT(Username) as user_count
    FROM UserDemographics
    GROUP BY GroupType, GroupValue
    ORDER BY GroupType, GroupValue
    '''
    
    try:
        cursor.execute(query)
        data = cursor.fetchall()
        return jsonify({'data': data})
    except Exception as e:
        current_app.logger.error(f'Error fetching demographic groups: {str(e)}')
        return jsonify({'error': str(e)}), 500

@users.route('/users/demographics/combine', methods=['POST'])
def combine_demographic_groups():
    cursor = db.get_db().cursor()
    data = request.get_json()
    
    if not data or 'group1' not in data or 'group2' not in data:
        return jsonify({'error': 'Missing group information'}), 400
        
    try:
        # Start a transaction
        cursor.execute('START TRANSACTION')
        
        # Update users from group2 to group1
        query = '''
        UPDATE UserDemographics 
        SET GroupValue = %s
        WHERE CONCAT(GroupType, ': ', GroupValue) = %s
        '''
        
        cursor.execute(query, (data['group1'], data['group2']))
        db.get_db().commit()
        
        return jsonify({'message': 'Groups combined successfully'})
    except Exception as e:
        db.get_db().rollback()
        current_app.logger.error(f'Error combining demographic groups: {str(e)}')
        return jsonify({'error': str(e)}), 500

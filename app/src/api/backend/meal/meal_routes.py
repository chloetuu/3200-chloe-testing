from flask import Blueprint, jsonify, request
import mysql.connector
from mysql.connector import Error

meal_bp = Blueprint('meal', __name__, url_prefix='/m')

# Database configuration
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'root',
    'database': 'Tummy'
}

def get_db_connection():
    try:
        connection = mysql.connector.connect(**db_config)
        return connection
    except Error as e:
        print(f"Error connecting to MySQL database: {e}")
        return None

@meal_bp.route('/meals', methods=['GET'])
def get_meals():
    connection = get_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            query = """
                SELECT 
                    m.RecipeID,
                    m.Name,
                    m.Difficulty,
                    m.ViewCount,
                    GROUP_CONCAT(t.TagName) as Tags
                FROM Meal m
                LEFT JOIN Meal_Tag mt ON m.RecipeID = mt.RecipeID
                LEFT JOIN Tag t ON mt.TagID = t.TagID
                GROUP BY m.RecipeID, m.Name, m.Difficulty, m.ViewCount
            """
            cursor.execute(query)
            meals = cursor.fetchall()
            
            # Convert Tags from string to list
            for meal in meals:
                meal['Tags'] = meal['Tags'].split(',') if meal['Tags'] else []
            
            return jsonify({'data': meals})
        except Error as e:
            return jsonify({'error': str(e)}), 500
        finally:
            connection.close()
    return jsonify({'error': 'Database connection failed'}), 500

@meal_bp.route('/meals/<int:recipe_id>', methods=['PUT'])
def update_meal(recipe_id):
    connection = get_db_connection()
    if connection:
        try:
            data = request.get_json()
            cursor = connection.cursor()
            
            update_query = """
                UPDATE Meal 
                SET Name = %s, Difficulty = %s, ViewCount = %s 
                WHERE RecipeID = %s
            """
            cursor.execute(update_query, (
                data['Name'],
                data['Difficulty'],
                data['ViewCount'],
                recipe_id
            ))
            
            connection.commit()
            return jsonify({'message': 'Meal updated successfully'})
        except Error as e:
            return jsonify({'error': str(e)}), 500
        finally:
            connection.close()
    return jsonify({'error': 'Database connection failed'}), 500

@meal_bp.route('/meals/analytics', methods=['GET'])
def get_meal_analytics():
    connection = get_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Get difficulty counts
            difficulty_query = """
                SELECT Difficulty, COUNT(*) as count
                FROM Meal
                GROUP BY Difficulty
            """
            cursor.execute(difficulty_query)
            difficulty_counts = cursor.fetchall()
            
            # Get tag counts
            tag_query = """
                SELECT t.TagName, COUNT(*) as count
                FROM Tag t
                JOIN Meal_Tag mt ON t.TagID = mt.TagID
                GROUP BY t.TagName
            """
            cursor.execute(tag_query)
            tag_counts = cursor.fetchall()
            
            # Get top meals by view count
            top_meals_query = """
                SELECT Name, ViewCount
                FROM Meal
                ORDER BY ViewCount DESC
                LIMIT 10
            """
            cursor.execute(top_meals_query)
            top_meals = cursor.fetchall()
            
            return jsonify({
                'data': {
                    'difficulty_counts': difficulty_counts,
                    'tag_counts': tag_counts,
                    'top_meals': top_meals
                }
            })
        except Error as e:
            return jsonify({'error': str(e)}), 500
        finally:
            connection.close()
    return jsonify({'error': 'Database connection failed'}), 500 
from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db

interactions = Blueprint('interactions', __name__)

@interactions.route('/interactions/analytics', methods=['GET'])
def get_interaction_analytics():
    current_app.logger.info('GET /interactions/analytics called')
    cursor = db.get_db().cursor()

    try:
        # 1. Interaction type distribution
        cursor.execute('''
            SELECT InteractionType, COUNT(*) AS count
            FROM Interaction
            GROUP BY InteractionType
        ''')
        type_counts = cursor.fetchall()

        # 2. Interactions over time
        cursor.execute('''
            SELECT DATE(Timestamp) AS date, COUNT(*) AS count
            FROM Interaction
            GROUP BY DATE(Timestamp)
            ORDER BY date ASC
        ''')
        time_series = cursor.fetchall()

        # 3. Top 10 most interacted meals
        cursor.execute('''
            SELECT m.Name, COUNT(*) AS count
            FROM Interaction i
            JOIN Meal m ON i.RecipeID = m.RecipeID
            GROUP BY m.Name
            ORDER BY count DESC
            LIMIT 10
        ''')
        top_meals = cursor.fetchall()

        return jsonify({
            'data': {
                'type_counts': type_counts,
                'time_series': time_series,
                'top_meals': top_meals
            }
        }), 200

    except Exception as e:
        current_app.logger.error(f'Error in /interactions/analytics: {str(e)}')
        return jsonify({'error': str(e)}), 500 
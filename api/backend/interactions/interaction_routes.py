from flask import Blueprint, jsonify, make_response, current_app
from backend.db_connection import db
import logging
from datetime import datetime, timedelta

logger = logging.getLogger(__name__)

interactions = Blueprint('interactions', __name__)

@interactions.route('/interactions/analytics', methods=['GET'])
def get_interaction_analytics():
    """Get interaction analytics data from the database"""
    try:
        cursor = db.get_db().cursor()
        
        # Get interaction type counts
        type_query = '''
            SELECT InteractionType, COUNT(*) as count
            FROM Interactions
            GROUP BY InteractionType
        '''
        cursor.execute(type_query)
        type_counts = cursor.fetchall()
        
        # Get time series data for last 7 days
        time_series_query = '''
            SELECT DATE(InteractionDate) as date, COUNT(*) as count
            FROM Interactions
            WHERE InteractionDate >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
            GROUP BY DATE(InteractionDate)
            ORDER BY date
        '''
        cursor.execute(time_series_query)
        time_series = cursor.fetchall()
        
        # Format the response
        data = {
            'type_counts': type_counts,
            'time_series': time_series
        }
        
        response = make_response(jsonify({'data': data}))
        response.status_code = 200
        response.mimetype = 'application/json'
        return response
        
    except Exception as e:
        logger.error(f"Error fetching interaction analytics: {str(e)}")
        return jsonify({'error': str(e)}), 500 
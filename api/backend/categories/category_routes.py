########################################################
# Sample categories blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, current_app
from backend.db_connection import db

#------------------------------------------------------------
# Create a new Blueprint object, which is a collection of 
# routes.
categories = Blueprint('categories', __name__)

@categories.route('/categories', methods=['GET'])
def get_all_categories():
    cursor = db.get_db().cursor()
    current_app.logger.info('GET /categories called')
    
    try:
        cursor.execute('SELECT * FROM CategoryData')
        categories = cursor.fetchall()
        return jsonify(categories)
    except Exception as e:
        current_app.logger.error(f'Error fetching categories: {str(e)}')
        return jsonify({'error': str(e)}), 500

@categories.route('/categories/init', methods=['POST'])
def init_categories():
    cursor = db.get_db().cursor()
    current_app.logger.info('POST /categories/init called')
    
    try:
        # Initialize categories
        categories = [
            "Appetizers", "Main Dishes", "Desserts", "Beverages", 
            "Sides", "Breakfast", "Lunch", "Dinner"
        ]
        
        for category in categories:
            cursor.execute('INSERT IGNORE INTO CategoryData (Name) VALUES (%s)', (category,))
        
        db.get_db().commit()
        current_app.logger.info('Successfully initialized categories')
        return jsonify({'message': 'Categories initialized successfully'})
    except Exception as e:
        current_app.logger.error(f'Error initializing categories: {str(e)}')
        return jsonify({'error': str(e)}), 500

@categories.route('/categories/<int:category_id>', methods=['GET'])
def get_category(category_id):
    cursor = db.get_db().cursor()
    current_app.logger.info(f'GET /categories/{category_id} called')
    
    try:
        cursor.execute('SELECT * FROM CategoryData WHERE CategoryID = %s', (category_id,))
        category = cursor.fetchone()
        if category:
            return jsonify(category)
        return jsonify({'error': 'Category not found'}), 404
    except Exception as e:
        current_app.logger.error(f'Error fetching category: {str(e)}')
        return jsonify({'error': str(e)}), 500

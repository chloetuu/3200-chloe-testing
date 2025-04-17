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
        cursor.execute('SELECT TagID as CategoryID, TagName as Name FROM Tag')
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
        # Initialize tags
        tags = [
            "Appetizers", "Main Dishes", "Desserts", "Beverages", 
            "Sides", "Breakfast", "Lunch", "Dinner"
        ]
        
        for tag in tags:
            cursor.execute('INSERT IGNORE INTO Tag (TagName) VALUES (%s)', (tag,))
        
        db.get_db().commit()
        current_app.logger.info('Successfully initialized tags')
        return jsonify({'message': 'Tags initialized successfully'})
    except Exception as e:
        current_app.logger.error(f'Error initializing tags: {str(e)}')
        return jsonify({'error': str(e)}), 500

@categories.route('/categories/<int:category_id>', methods=['GET'])
def get_category(category_id):
    cursor = db.get_db().cursor()
    current_app.logger.info(f'GET /categories/{category_id} called')
    
    try:
        cursor.execute('SELECT TagID as CategoryID, TagName as Name FROM Tag WHERE TagID = %s', (category_id,))
        category = cursor.fetchone()
        if category:
            return jsonify(category)
        return jsonify({'error': 'Category not found'}), 404
    except Exception as e:
        current_app.logger.error(f'Error fetching category: {str(e)}')
        return jsonify({'error': str(e)}), 500

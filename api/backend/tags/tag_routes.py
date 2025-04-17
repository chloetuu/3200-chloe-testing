from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db

# Create a new Blueprint object for both tags and categories
tags_categories = Blueprint('tags_categories', __name__)

# --- Tag/Category Management ---
@tags_categories.route('/tags', methods=['GET'])
def get_all_tags():
    """Get all tags/categories"""
    cursor = db.get_db().cursor()
    current_app.logger.info('GET /tags called')
    
    query = '''
    SELECT TagID, TagName
    FROM Tag
    ORDER BY TagName
    '''
    
    try:
        cursor.execute(query)
        tags = cursor.fetchall()
        return jsonify(tags)
    except Exception as e:
        current_app.logger.error(f'Error fetching tags: {str(e)}')
        return jsonify({'error': str(e)}), 500

@tags_categories.route('/tags/init', methods=['POST'])
def init_tags():
    """Initialize default tags/categories"""
    cursor = db.get_db().cursor()
    current_app.logger.info('POST /tags/init called')
    
    try:
        # Initialize default tags
        default_tags = [
            "Appetizers", "Main Dishes", "Desserts", "Beverages", 
            "Sides", "Breakfast", "Lunch", "Dinner"
        ]
        
        for tag in default_tags:
            cursor.execute('INSERT IGNORE INTO Tag (TagName) VALUES (%s)', (tag,))
        
        db.get_db().commit()
        current_app.logger.info('Successfully initialized tags')
        return jsonify({'message': 'Tags initialized successfully'})
    except Exception as e:
        current_app.logger.error(f'Error initializing tags: {str(e)}')
        return jsonify({'error': str(e)}), 500

@tags_categories.route('/tags/<int:tag_id>', methods=['GET'])
def get_tag(tag_id):
    """Get a specific tag/category by ID"""
    cursor = db.get_db().cursor()
    current_app.logger.info(f'GET /tags/{tag_id} called')
    
    query = '''
    SELECT TagID, TagName
    FROM Tag
    WHERE TagID = %s
    '''
    
    try:
        cursor.execute(query, (tag_id,))
        tag = cursor.fetchone()
        if tag:
            return jsonify(tag)
        else:
            return jsonify({'error': 'Tag not found'}), 404
    except Exception as e:
        current_app.logger.error(f'Error fetching tag: {str(e)}')
        return jsonify({'error': str(e)}), 500

# --- Tag Requests ---
@tags_categories.route('/tags/requests', methods=['GET'])
def get_tag_requests():
    """Get all pending tag requests"""
    cursor = db.get_db().cursor()
    
    query = '''
    SELECT 
        tr.RequestID,
        tr.TagName,
        tr.RequestedBy,
        tr.Status,
        tr.RequestDate,
        COUNT(DISTINCT m.RecipeID) as potential_recipes
    FROM TagRequest tr
    LEFT JOIN Meal m ON LOWER(m.Description) LIKE CONCAT('%', LOWER(tr.TagName), '%')
    WHERE tr.Status = 'PENDING'
    GROUP BY tr.RequestID, tr.TagName, tr.RequestedBy, tr.Status, tr.RequestDate
    ORDER BY tr.RequestDate DESC
    '''
    
    try:
        cursor.execute(query)
        data = cursor.fetchall()
        return jsonify({'data': data})
    except Exception as e:
        current_app.logger.error(f'Error fetching tag requests: {str(e)}')
        return jsonify({'error': str(e)}), 500

@tags_categories.route('/tags/requests', methods=['POST'])
def create_tag_request():
    """Create a new tag request"""
    cursor = db.get_db().cursor()
    data = request.json
    
    try:
        cursor.execute('''
            INSERT INTO TagRequest (TagName, RequestedBy, Status, RequestDate)
            VALUES (%s, %s, 'PENDING', NOW())
        ''', (data['tag_name'], data['requested_by']))
        
        db.get_db().commit()
        return jsonify({'message': 'Tag request created successfully'})
    except Exception as e:
        current_app.logger.error(f'Error creating tag request: {str(e)}')
        return jsonify({'error': str(e)}), 500

@tags_categories.route('/tags/requests/<int:request_id>', methods=['PUT'])
def update_tag_request(request_id):
    """Update a tag request status"""
    cursor = db.get_db().cursor()
    data = request.json
    
    try:
        cursor.execute('''
            UPDATE TagRequest 
            SET Status = %s 
            WHERE RequestID = %s
        ''', (data['status'], request_id))
        
        db.get_db().commit()
        return jsonify({'message': 'Tag request updated successfully'})
    except Exception as e:
        current_app.logger.error(f'Error updating tag request: {str(e)}')
        return jsonify({'error': str(e)}), 500

@tags_categories.route('/tags', methods=['POST'])
def create_tag():
    cursor = db.get_db().cursor()
    current_app.logger.info('POST /tags called')
    
    data = request.get_json()
    if not data or 'TagName' not in data:
        return jsonify({'error': 'Missing tag name'}), 400
    
    query = '''
    INSERT INTO Tag (TagName)
    VALUES (%s)
    '''
    
    try:
        cursor.execute(query, (data['TagName'],))
        db.get_db().commit()
        return jsonify({'message': 'Tag created successfully'}), 201
    except Exception as e:
        db.get_db().rollback()
        current_app.logger.error(f'Error creating tag: {str(e)}')
        return jsonify({'error': str(e)}), 500 
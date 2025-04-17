from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db

tags = Blueprint('tags', __name__)

@tags.route('/tags/requests', methods=['GET'])
def get_tag_requests():
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

@tags.route('/tags/requests/<int:request_id>/approve', methods=['POST'])
def approve_tag_request(request_id):
    cursor = db.get_db().cursor()
    
    try:
        # Start a transaction
        cursor.execute('START TRANSACTION')
        
        # Get the tag request details
        cursor.execute('SELECT TagName FROM TagRequest WHERE RequestID = %s', (request_id,))
        tag_request = cursor.fetchone()
        
        if not tag_request:
            return jsonify({'error': 'Tag request not found'}), 404
            
        # Add the new tag
        cursor.execute('INSERT INTO Tag (TagName) VALUES (%s)', (tag_request['TagName'],))
        new_tag_id = cursor.lastrowid
        
        # Update the request status
        cursor.execute(
            'UPDATE TagRequest SET Status = %s WHERE RequestID = %s',
            ('APPROVED', request_id)
        )
        
        # Commit the transaction
        db.get_db().commit()
        
        return jsonify({'message': 'Tag request approved successfully'})
    except Exception as e:
        db.get_db().rollback()
        current_app.logger.error(f'Error approving tag request: {str(e)}')
        return jsonify({'error': str(e)}), 500

@tags.route('/tags/requests/<int:request_id>/reject', methods=['POST'])
def reject_tag_request(request_id):
    cursor = db.get_db().cursor()
    
    try:
        cursor.execute(
            'UPDATE TagRequest SET Status = %s WHERE RequestID = %s',
            ('REJECTED', request_id)
        )
        db.get_db().commit()
        
        return jsonify({'message': 'Tag request rejected successfully'})
    except Exception as e:
        current_app.logger.error(f'Error rejecting tag request: {str(e)}')
        return jsonify({'error': str(e)}), 500 
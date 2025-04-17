from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict  # Only if you're using this

alerts = Blueprint('alerts', __name__)

# GET all alerts
@alerts.route('/alerts', methods=['GET'])
def get_alerts():
    try:
        cursor = db.get_db().cursor()
        query = '''
            SELECT a.AlertID, a.Type, a.Timestamp, a.AssignedTo, a.Status,
                   l.SeverityLevel, l.Source, l.Details, l.ErrorMessage
            FROM Alert a
            LEFT JOIN LogEntry l ON a.LogID = l.LogID
            ORDER BY a.Timestamp DESC
        '''
        cursor.execute(query)
        column_headers = [x[0] for x in cursor.description]
        data = cursor.fetchall()
        
        # Convert to dictionary format
        json_data = []
        for result in data:
            json_data.append(dict(zip(column_headers, result)))
            
        response = make_response(jsonify(json_data))
        response.status_code = 200
        response.mimetype = 'application/json'
        return response
    except Exception as e:
        current_app.logger.error(f"Error fetching alerts: {str(e)}")
        return jsonify({'error': 'Failed to fetch alerts'}), 500

# POST a new alert
@alerts.route('/alerts', methods=['POST'])
def add_alert():
    try:
        current_app.logger.info('POST /alerts route')
        alert_info = request.json

        # First create a log entry
        log_query = '''
            INSERT INTO LogEntry (Timestamp, SeverityLevel, Source, Details, ErrorMessage)
            VALUES (%s, %s, %s, %s, %s)
        '''
        log_data = (
            alert_info.get('timestamp'),
            alert_info.get('severity_level', 'INFO'),
            alert_info.get('source', 'System'),
            alert_info.get('details', ''),
            alert_info.get('error_message', '')
        )

        cursor = db.get_db().cursor()
        cursor.execute(log_query, log_data)
        log_id = cursor.lastrowid

        # Then create the alert
        alert_query = '''
            INSERT INTO Alert (Type, Timestamp, AssignedTo, LogID)
            VALUES (%s, %s, %s, %s)
        '''
        alert_data = (
            alert_info.get('type', 'System'),
            alert_info.get('timestamp'),
            alert_info.get('assigned_to'),
            log_id
        )

        cursor.execute(alert_query, alert_data)
        db.get_db().commit()

        return jsonify({'message': 'Alert added successfully', 'alert_id': cursor.lastrowid}), 201
    except Exception as e:
        current_app.logger.error(f"Error adding alert: {str(e)}")
        db.get_db().rollback()
        return jsonify({'error': 'Failed to add alert'}), 500

# DELETE an alert
@alerts.route('/alerts/<int:alert_id>', methods=['DELETE'])
def delete_alert(alert_id):
    try:
        current_app.logger.info(f'DELETE /alerts/{alert_id} route called')

        # First get the LogID
        cursor = db.get_db().cursor()
        cursor.execute('SELECT LogID FROM Alert WHERE AlertID = %s', (alert_id,))
        result = cursor.fetchone()
        
        if not result:
            return jsonify({'error': 'Alert not found'}), 404
            
        log_id = result[0]

        # Delete the alert
        cursor.execute('DELETE FROM Alert WHERE AlertID = %s', (alert_id,))
        
        # Delete the associated log entry
        cursor.execute('DELETE FROM LogEntry WHERE LogID = %s', (log_id,))
        
        db.get_db().commit()

        return jsonify({'message': 'Alert deleted successfully'}), 200
    except Exception as e:
        current_app.logger.error(f"Error deleting alert: {str(e)}")
        db.get_db().rollback()
        return jsonify({'error': 'Failed to delete alert'}), 500

# UPDATE alert status
@alerts.route('/alerts/<int:alert_id>/status', methods=['PUT'])
def update_alert_status(alert_id):
    try:
        current_app.logger.info(f'PUT /alerts/{alert_id}/status route called')
        
        status_info = request.json
        if not status_info or 'status' not in status_info:
            return jsonify({'error': 'Status is required'}), 400
            
        new_status = status_info['status']
        
        cursor = db.get_db().cursor()
        cursor.execute('UPDATE Alert SET Status = %s WHERE AlertID = %s', (new_status, alert_id))
        
        if cursor.rowcount == 0:
            return jsonify({'error': 'Alert not found'}), 404
            
        db.get_db().commit()
        
        return jsonify({'message': 'Alert status updated successfully'}), 200
    except Exception as e:
        current_app.logger.error(f"Error updating alert status: {str(e)}")
        db.get_db().rollback()
        return jsonify({'error': 'Failed to update alert status'}), 500

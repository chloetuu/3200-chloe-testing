from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict  # Only if you're using this

alerts = Blueprint('alerts', __name__)

# GET all alerts
@alerts.route('/alert', methods=['GET'])
def get_alerts():
    cursor = db.get_db().cursor()
    query = '''
        SELECT AlertID, LogID, AssignedTo, Timestamp, Type, Status
        FROM Alert
    '''
    cursor.execute(query)
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    response.mimetype = 'application/json'
    return response

# POST a new alert
@alerts.route('/alert', methods=['POST'])
def add_alert():
    current_app.logger.info('POST /alert route')
    alert_info = request.json

    log_id = alert_info['log_id']
    assigned_to = alert_info['assigned_to']
    timestamp = alert_info['timestamp']
    alert_type = alert_info['type']
    status = alert_info['status']

    query = '''
        INSERT INTO Alert (LogID, AssignedTo, Timestamp, Type, Status)
        VALUES (%s, %s, %s, %s, %s)
    '''
    data = (log_id, assigned_to, timestamp, alert_type, status)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return jsonify({'message': 'Alert added successfully'}), 201

# DELETE an alert
@alerts.route('/alert/<int:alert_id>', methods=['DELETE'])
def delete_alert(alert_id):
    current_app.logger.info(f'DELETE /alert/{alert_id} route called')

    query = '''DELETE FROM Alert WHERE AlertID = %s'''
    cursor = db.get_db().cursor()
    cursor.execute(query, (alert_id,))
    db.get_db().commit()

    return jsonify({'message': 'Alert deleted!'}), 200

# UPDATE alert status
@alerts.route('/alert/<int:alert_id>/status', methods=['PUT'])
def update_alert_status(alert_id):
    current_app.logger.info(f'PUT /alert/{alert_id}/status route called')
    
    status_info = request.json
    new_status = status_info['status']
    
    query = '''UPDATE Alert SET Status = %s WHERE AlertID = %s'''
    cursor = db.get_db().cursor()
    cursor.execute(query, (new_status, alert_id))
    db.get_db().commit()
    
    return jsonify({'message': 'Alert status updated!'}), 200

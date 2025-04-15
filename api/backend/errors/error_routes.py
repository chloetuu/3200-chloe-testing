from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict  # Only if you're using this

issues = Blueprint('issues', __name__)

# GET all logs
@issues.route('/log', methods=['GET'])
def get_logs():
    cursor = db.get_db().cursor()
    query = '''
        SELECT LogID, Timestamp, ErrorMessage, SeverityLevel, Source, Details
        FROM LogEntry
    '''
    cursor.execute(query)
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    response.mimetype = 'application/json'
    return response

# POST a new log
@issues.route('/log', methods=['POST'])
def add_log():
    current_app.logger.info('POST /log route')
    log_info = request.json

    log_id = log_info['log_id']
    timestamp = log_info['timestamp']
    error_message = log_info['error_message']
    severity = log_info['severity']
    source = log_info['source']
    details = log_info['details']
    notes = log_info.get('notes', '')

    query = '''
        INSERT INTO IssueReport (LogID, Timestamp, ErrorMessage, SeverityLevel, Source, Details, Notes)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    '''
    data = (log_id, timestamp, error_message, severity, source, details, notes)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return jsonify({'message': 'Log added successfully'}), 201

# DELETE a log
@issues.route('/log/<int:log_id>', methods=['DELETE'])
def delete_log(log_id):
    current_app.logger.info(f'DELETE /log/{log_id} route called')

    query = '''DELETE FROM LogEntry WHERE LogID = %s'''
    cursor = db.get_db().cursor()
    cursor.execute(query, (log_id,))
    db.get_db().commit()

    return jsonify({'message': 'Log entry deleted!'}), 200

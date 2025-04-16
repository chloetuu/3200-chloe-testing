########################################################
# Sample categories blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict

#------------------------------------------------------------
# Create a new Blueprint object, which is a collection of 
# routes.
categories = Blueprint('categories', __name__)

# Get all customers from the system
@categories.route('/categories', methods=['GET'])
def get_categories():

    cursor = db.get_db().cursor()

    cursor.execute('''
                   SELECT * FROM CategoryData
    ''')
    
    theData = cursor.fetchall()
    
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Gets a single category from the system from the CategoryID
@categories.route('/categories/<int:category_id>', methods=['GET'])
def get_category_by_id(category_id):
    cursor = db.get_db().cursor()
    
    query = '''SELECT * FROM CategoryData WHERE CategoryID = %s'''
    cursor.execute(query, (category_id,))
    
    result = cursor.fetchone()

    if result:
        response = make_response(jsonify(result))
        response.status_code = 200
    else:
        response = make_response(jsonify({"error": "Category not found"}), 404)

    response.mimetype = 'application/json'
    return response

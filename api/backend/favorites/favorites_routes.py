########################################################
# Sample favorites blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################

from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db

favorites = Blueprint('favorites', __name__)

# Gets all favorite meals
@favorites.route('/favorites', methods=['GET'])
def get_all_favorites():
    cursor = db.get_db().cursor()
    query = '''
        SELECT * FROM Saved_Meals
    '''
    cursor.execute(query)
    data = cursor.fetchall()
    
    response = make_response(jsonify(data))
    response.status_code = 200
    response.mimetype = 'application/json'
    return response

# Adds a meal to favorites
@favorites.route('/favorites', methods=['POST'])
def add_favorite():
    current_app.logger.info('POST /favorites route called')
    fav_info = request.json
    username = fav_info['username']
    recipe_id = fav_info['recipe_id']

    query = '''
        INSERT INTO Saved_Meals (Username, RecipeID)
        VALUES (%s, %s)
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query, (username, recipe_id))
    db.get_db().commit()

    return 'Meal added to Favorites!', 201

# Deletes a favorited meal
@favorites.route('/favorites/<int:recipe_id>', methods=['DELETE'])
def delete_favorite(recipe_id):
    current_app.logger.info(f'DELETE /favorites/{recipe_id} route called')

    query = '''
        DELETE FROM Saved_Meals WHERE RecipeID = %s
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query, (recipe_id,))
    db.get_db().commit()

    return 'Meal removed from Favorites!', 200

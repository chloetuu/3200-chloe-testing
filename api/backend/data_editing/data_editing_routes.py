from flask import Blueprint, jsonify, request
from backend.database import get_db_connection
import logging

logger = logging.getLogger(__name__)

data_editing = Blueprint('data_editing', __name__)

@data_editing.route('/data/meals', methods=['GET'])
def get_meals():
    """Get all meals with their details"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        # Get all meals with their tags and ingredients
        cursor.execute("""
            SELECT m.*, 
                   GROUP_CONCAT(DISTINCT t.TagName) as tags,
                   GROUP_CONCAT(DISTINCT i.Name) as ingredients
            FROM Meals m
            LEFT JOIN MealTags mt ON m.MealID = mt.MealID
            LEFT JOIN Tags t ON mt.TagID = t.TagID
            LEFT JOIN MealIngredients mi ON m.MealID = mi.MealID
            LEFT JOIN Ingredients i ON mi.IngredientID = i.IngredientID
            GROUP BY m.MealID
        """)
        meals = cursor.fetchall()
        
        # Format the results
        formatted_meals = []
        for meal in meals:
            formatted_meal = {
                'id': meal['MealID'],
                'name': meal['Name'],
                'description': meal['Description'],
                'difficulty': meal['Difficulty'],
                'prep_time': meal['PrepTime'],
                'cook_time': meal['CookTime'],
                'servings': meal['Servings'],
                'tags': meal['tags'].split(',') if meal['tags'] else [],
                'ingredients': meal['ingredients'].split(',') if meal['ingredients'] else []
            }
            formatted_meals.append(formatted_meal)
        
        return jsonify({'data': formatted_meals})
    except Exception as e:
        logger.error(f"Error fetching meals: {str(e)}")
        return jsonify({'error': str(e)}), 500
    finally:
        if 'conn' in locals():
            conn.close()

@data_editing.route('/data/meals/<int:meal_id>', methods=['PUT'])
def update_meal(meal_id):
    """Update a meal's details"""
    try:
        data = request.get_json()
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Update meal details
        cursor.execute("""
            UPDATE Meals 
            SET Name = %s, Description = %s, Difficulty = %s,
                PrepTime = %s, CookTime = %s, Servings = %s
            WHERE MealID = %s
        """, (
            data['name'], data['description'], data['difficulty'],
            data['prep_time'], data['cook_time'], data['servings'],
            meal_id
        ))
        
        # Update tags
        if 'tags' in data:
            # First remove all existing tags
            cursor.execute("DELETE FROM MealTags WHERE MealID = %s", (meal_id,))
            # Then add new tags
            for tag in data['tags']:
                cursor.execute("""
                    INSERT INTO MealTags (MealID, TagID)
                    SELECT %s, TagID FROM Tags WHERE TagName = %s
                """, (meal_id, tag))
        
        # Update ingredients
        if 'ingredients' in data:
            # First remove all existing ingredients
            cursor.execute("DELETE FROM MealIngredients WHERE MealID = %s", (meal_id,))
            # Then add new ingredients
            for ingredient in data['ingredients']:
                cursor.execute("""
                    INSERT INTO MealIngredients (MealID, IngredientID)
                    SELECT %s, IngredientID FROM Ingredients WHERE Name = %s
                """, (meal_id, ingredient))
        
        conn.commit()
        return jsonify({'message': 'Meal updated successfully'})
    except Exception as e:
        logger.error(f"Error updating meal: {str(e)}")
        return jsonify({'error': str(e)}), 500
    finally:
        if 'conn' in locals():
            conn.close()

@data_editing.route('/data/meals', methods=['POST'])
def create_meal():
    """Create a new meal"""
    try:
        data = request.get_json()
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Insert new meal
        cursor.execute("""
            INSERT INTO Meals (Name, Description, Difficulty, PrepTime, CookTime, Servings)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            data['name'], data['description'], data['difficulty'],
            data['prep_time'], data['cook_time'], data['servings']
        ))
        
        meal_id = cursor.lastrowid
        
        # Add tags
        if 'tags' in data:
            for tag in data['tags']:
                cursor.execute("""
                    INSERT INTO MealTags (MealID, TagID)
                    SELECT %s, TagID FROM Tags WHERE TagName = %s
                """, (meal_id, tag))
        
        # Add ingredients
        if 'ingredients' in data:
            for ingredient in data['ingredients']:
                cursor.execute("""
                    INSERT INTO MealIngredients (MealID, IngredientID)
                    SELECT %s, IngredientID FROM Ingredients WHERE Name = %s
                """, (meal_id, ingredient))
        
        conn.commit()
        return jsonify({'message': 'Meal created successfully', 'id': meal_id})
    except Exception as e:
        logger.error(f"Error creating meal: {str(e)}")
        return jsonify({'error': str(e)}), 500
    finally:
        if 'conn' in locals():
            conn.close()

@data_editing.route('/data/meals/<int:meal_id>', methods=['DELETE'])
def delete_meal(meal_id):
    """Delete a meal"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Delete meal tags and ingredients first (due to foreign key constraints)
        cursor.execute("DELETE FROM MealTags WHERE MealID = %s", (meal_id,))
        cursor.execute("DELETE FROM MealIngredients WHERE MealID = %s", (meal_id,))
        
        # Delete the meal
        cursor.execute("DELETE FROM Meals WHERE MealID = %s", (meal_id,))
        
        conn.commit()
        return jsonify({'message': 'Meal deleted successfully'})
    except Exception as e:
        logger.error(f"Error deleting meal: {str(e)}")
        return jsonify({'error': str(e)}), 500
    finally:
        if 'conn' in locals():
            conn.close() 
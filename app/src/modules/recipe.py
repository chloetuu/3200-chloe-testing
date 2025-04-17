import requests

def get_all_categories():
    """
    Get all available recipe categories from the API
    """
    try:
        response = requests.get("http://api:4000/m/categories")
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException:
        return ["Breakfast", "Lunch", "Dinner", "Dessert", "Snack"]  # Fallback categories

def get_recipes_by_category(category):
    """
    Get all recipes for a specific category from the API
    """
    try:
        response = requests.get(f"http://api:4000/m/meals/category/{category}")
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException:
        return []  # Return empty list if API call fails 
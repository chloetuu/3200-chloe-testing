import streamlit as st
import requests
import pandas as pd
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Data Editing Dashboard")

"""
This dashboard allows you to view, create, edit, and delete meal data in the database.
"""

# Function to fetch meals from the API
def fetch_meals():
    try:
        response = requests.get('http://localhost:4001/d/data/meals')
        if response.status_code == 200:
            return response.json().get('data', [])
        else:
            st.error(f"Error fetching meals: {response.status_code}")
            return []
    except Exception as e:
        st.error(f"Error connecting to API: {str(e)}")
        return []

# Function to create a new meal
def create_meal(meal_data):
    try:
        response = requests.post('http://localhost:4001/d/data/meals', json=meal_data)
        if response.status_code == 200:
            st.success("Meal created successfully!")
        else:
            st.error(f"Error creating meal: {response.status_code}")
    except Exception as e:
        st.error(f"Error connecting to API: {str(e)}")

# Function to update a meal
def update_meal(meal_id, meal_data):
    try:
        response = requests.put(f'http://localhost:4001/d/data/meals/{meal_id}', json=meal_data)
        if response.status_code == 200:
            st.success("Meal updated successfully!")
        else:
            st.error(f"Error updating meal: {response.status_code}")
    except Exception as e:
        st.error(f"Error connecting to API: {str(e)}")

# Function to delete a meal
def delete_meal(meal_id):
    try:
        response = requests.delete(f'http://localhost:4001/d/data/meals/{meal_id}')
        if response.status_code == 200:
            st.success("Meal deleted successfully!")
        else:
            st.error(f"Error deleting meal: {response.status_code}")
    except Exception as e:
        st.error(f"Error connecting to API: {str(e)}")

# Create tabs for different operations
tab1, tab2, tab3 = st.tabs(["View Meals", "Create Meal", "Edit/Delete Meal"])

# View Meals Tab
with tab1:
    st.subheader("View All Meals")
    meals = fetch_meals()
    if meals:
        df = pd.DataFrame(meals)
        st.dataframe(df)

# Create Meal Tab
with tab2:
    st.subheader("Create New Meal")
    with st.form("create_meal_form"):
        name = st.text_input("Meal Name")
        description = st.text_area("Description")
        difficulty = st.selectbox("Difficulty", ["Easy", "Medium", "Hard"])
        prep_time = st.number_input("Preparation Time (minutes)", min_value=0)
        cook_time = st.number_input("Cooking Time (minutes)", min_value=0)
        servings = st.number_input("Servings", min_value=1)
        tags = st.multiselect("Tags", ["Vegetarian", "Vegan", "Gluten-Free", "Dairy-Free", "Quick", "Healthy"])
        ingredients = st.text_area("Ingredients (one per line)").split('\n')
        
        submitted = st.form_submit_button("Create Meal")
        if submitted:
            meal_data = {
                "name": name,
                "description": description,
                "difficulty": difficulty,
                "prep_time": prep_time,
                "cook_time": cook_time,
                "servings": servings,
                "tags": tags,
                "ingredients": ingredients
            }
            create_meal(meal_data)

# Edit/Delete Meal Tab
with tab3:
    st.subheader("Edit or Delete Meal")
    meals = fetch_meals()
    if meals:
        meal_options = {f"{meal['name']} (ID: {meal['id']})": meal['id'] for meal in meals}
        selected_meal = st.selectbox("Select a meal to edit or delete", options=list(meal_options.keys()))
        meal_id = meal_options[selected_meal]
        
        # Get the selected meal's details
        selected_meal_data = next((meal for meal in meals if meal['id'] == meal_id), None)
        
        if selected_meal_data:
            with st.form("edit_meal_form"):
                name = st.text_input("Meal Name", value=selected_meal_data['name'])
                description = st.text_area("Description", value=selected_meal_data['description'])
                difficulty = st.selectbox("Difficulty", ["Easy", "Medium", "Hard"], 
                                        index=["Easy", "Medium", "Hard"].index(selected_meal_data['difficulty']))
                prep_time = st.number_input("Preparation Time (minutes)", min_value=0, 
                                          value=selected_meal_data['prep_time'])
                cook_time = st.number_input("Cooking Time (minutes)", min_value=0, 
                                          value=selected_meal_data['cook_time'])
                servings = st.number_input("Servings", min_value=1, value=selected_meal_data['servings'])
                tags = st.multiselect("Tags", ["Vegetarian", "Vegan", "Gluten-Free", "Dairy-Free", "Quick", "Healthy"],
                                    default=selected_meal_data['tags'])
                ingredients = st.text_area("Ingredients (one per line)", 
                                         value='\n'.join(selected_meal_data['ingredients'])).split('\n')
                
                col1, col2 = st.columns(2)
                with col1:
                    update_submitted = st.form_submit_button("Update Meal")
                with col2:
                    delete_submitted = st.form_submit_button("Delete Meal")
                
                if update_submitted:
                    meal_data = {
                        "name": name,
                        "description": description,
                        "difficulty": difficulty,
                        "prep_time": prep_time,
                        "cook_time": cook_time,
                        "servings": servings,
                        "tags": tags,
                        "ingredients": ingredients
                    }
                    update_meal(meal_id, meal_data)
                
                if delete_submitted:
                    delete_meal(meal_id)
    else:
        st.warning("No meals found in the database.")




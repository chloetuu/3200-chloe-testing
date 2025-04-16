import streamlit as st
import requests
import json
from modules.nav import SideBarLinks

st.set_page_config(layout="wide", page_title="My Favorite Meals")

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title("📋 My Favorite Meals")

# Check if user is logged in
if 'first_name' not in st.session_state:
    st.error("Please log in to view your favorite meals.")
    st.stop()

# Initialize test data if needed
if 'favorites_initialized' not in st.session_state:
    try:
        init_response = requests.post("http://api:4000/f/favorites/init")
        if init_response.status_code == 200:
            st.session_state.favorites_initialized = True
    except Exception as e:
        st.warning("Could not connect to initialization endpoint. This is okay if you already have favorites.")

# Fetch favorite meals
try:
    response = requests.get(f"http://api:4000/f/favorites?username={st.session_state['first_name'].lower()}")
    
    if response.status_code == 200:
        meals = response.json()
        
        if not meals:
            st.info("You haven't favorited any meals yet. Try exploring some recipes!")
        else:
            st.write(f"Found {len(meals)} favorite meals!")
            
            for meal in meals:
                with st.expander(f"🍽️ {meal['Name']}"):
                    col1, col2 = st.columns(2)
                    
                    with col1:
                        # Add image for the meal
                        st.image(f"assets/{meal['RecipeID'] % 8}.png", width=350)
                        st.write(f"- 🍽️ Prep Time: {meal['PrepTime']} minutes")
                        st.write(f"- 🕒 Cook Time: {meal['CookTime']} minutes")
                        st.write(f"- ⏰ Total Time: {meal['TotalTime']} minutes")
                        st.write(f"- 😊 Difficulty: {meal['Difficulty']}")
                        
                        st.write("**Ingredients:**")
                        for ingredient in meal['Ingredients'].split(';'):
                            st.write(f"- {ingredient.strip()}")
                    
                    with col2:
                        st.write("**Instructions:**")
                        for step in meal['Instructions'].split(';'):
                            st.write(f"{step.strip()}")
                        
                        # Add delete button
                        if st.button("🗑️ Remove from Favorites", key=f"delete_{meal['RecipeID']}"):
                            try:
                                # Call the favorites API to delete the meal
                                delete_response = requests.delete(
                                    f"http://api:4000/f/favorites/{meal['RecipeID']}?username={st.session_state['first_name'].lower()}"
                                )
                                if delete_response.status_code == 200:
                                    st.success("Removed from favorites!")
                                    # Refresh the page to show updated list
                                    st.rerun()
                                else:
                                    st.error("Failed to remove from favorites. Please try again.")
                            except Exception as e:
                                st.error(f"Error removing from favorites: {str(e)}")
    else:
        st.error(f"Error fetching favorite meals: {response.text}")
except Exception as e:
    st.error(f"Could not connect to the API: {str(e)}")

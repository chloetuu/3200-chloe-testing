import streamlit as st
import requests
import json
from modules.nav import SideBarLinks
from datetime import datetime

def format_date(date_str):
    try:
        # Try parsing the API date format
        date = datetime.strptime(date_str, '%a, %d %b %Y %H:%M:%S GMT')
        return date.strftime('%B %d, %Y')
    except:
        # If that fails, try direct format
        try:
            date = datetime.strptime(date_str, '%Y-%m-%d')
            return date.strftime('%B %d, %Y')
        except:
            return date_str  # Return original if parsing fails

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
            
            # Add search functionality
            search = st.text_input("🔍 Search your favorites", "")
            
            # Filter meals based on search
            if search:
                meals = [meal for meal in meals if search.lower() in meal['Name'].lower()]
            
            for meal in meals:
                with st.expander(f"🍽️ {meal['Name']}"):
                    col1, col2 = st.columns([3, 1])
                    
                    with col1:
                        st.image(f"assets/{meal['RecipeID'] % 8}.png", width=350)
                        
                        # Display tags if available
                        if meal.get('Tags'):
                            tags = meal['Tags'].split(',')
                            st.write("🏷️ Tags:", ", ".join(tags))
                        
                        # Format date if available
                        if 'DateCreated' in meal:
                            formatted_date = format_date(meal['DateCreated'])
                            st.write(f"📅 Created: {formatted_date}")
                        
                        st.write(f"⏱️ Preparation: {meal['PrepTime']} minutes")
                        st.write(f"🔥 Cooking: {meal['CookTime']} minutes")
                        st.write(f"⏰ Total Time: {meal['TotalTime']} minutes")
                        st.write(f"📊 Difficulty: {meal['Difficulty']}")
                        
                        # Display ingredients in a more organized way
                        st.write("🧂 **Ingredients:**")
                        ingredients = [ing.strip() for ing in meal['Ingredients'].split(';')]
                        for ingredient in ingredients:
                            st.write(f"  • {ingredient}")
                        
                        # Display instructions as numbered steps
                        st.write("📝 **Instructions:**")
                        instructions = [inst.strip() for inst in meal['Instructions'].split('.') if inst.strip()]
                        for i, instruction in enumerate(instructions, 1):
                            st.write(f"  {i}. {instruction}")
                        
                        if 'ViewCount' in meal:
                            st.write(f"👀 Views: {meal['ViewCount']}")
                    
                    with col2:
                        # Add delete button
                        if st.button("🗑️ Remove from Favorites", key=f"delete_{meal['RecipeID']}"):
                            try:
                                delete_response = requests.delete(
                                    f"http://api:4000/f/favorites/{meal['RecipeID']}?username={st.session_state['first_name'].lower()}"
                                )
                                if delete_response.status_code == 200:
                                    st.success("Removed from favorites!")
                                    st.rerun()
                                else:
                                    st.error("Failed to remove from favorites. Please try again.")
                            except Exception as e:
                                st.error(f"Error removing from favorites: {str(e)}")
    else:
        st.error(f"Error fetching favorite meals: {response.text}")
except Exception as e:
    st.error(f"Could not connect to the API: {str(e)}")

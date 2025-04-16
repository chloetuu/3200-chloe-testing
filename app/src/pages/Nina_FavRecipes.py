import streamlit as st
import requests
import json

st.set_page_config(layout="wide", page_title="My Favorite Meals")

st.title("📋 My Favorite Meals")

# Add back button to sidebar
with st.sidebar:
    if st.button("🏠 Back to Home"):
        st.switch_page("pages/Nina_HomePage.py")

# Check if user is logged in
if 'first_name' not in st.session_state:
    st.error("Please log in to view your favorite meals.")
    st.stop()

# Initialize test data if needed
try:
    init_response = requests.post("http://api:4000/f/favorites/init")
    if init_response.status_code == 200:
        st.success("Test data initialized successfully!")
    else:
        st.warning("Could not initialize test data. This is okay if you already have favorites.")
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
                        st.write("**Prep Time:**", meal['PrepTime'])
                        st.write("**Cook Time:**", meal['CookTime'])
                        st.write("**Difficulty:**", meal['Difficulty'])
                        
                        st.write("**Ingredients:**")
                        for ingredient in meal['Ingredients'].split(';'):
                            st.write(f"- {ingredient.strip()}")
                    
                    with col2:
                        st.write("**Instructions:**")
                        for step in meal['Instructions'].split(';'):
                            st.write(f"{step.strip()}")
    else:
        st.error(f"Error fetching favorite meals: {response.text}")
except Exception as e:
    st.error(f"Could not connect to the API: {str(e)}")

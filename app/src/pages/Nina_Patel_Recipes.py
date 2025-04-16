import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout="wide", page_title="Explore All Meals")

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title("📋 Explore All Meals")

# Check if user is logged in
if 'first_name' not in st.session_state:
    st.error("Please log in to view and favorite meals.")
    st.stop()

try:
    # 🔁 Call your Flask API endpoint
    response = requests.get("http://api:4000/m/meals")  
    response.raise_for_status()

    meals = response.json()

    if meals:
        for i, meal in enumerate(meals):
            col1, col2 = st.columns([3, 1])
            
            with col1:
                st.image(f"assets/{i % 8}.png", width=350)
                st.markdown(f"### {meal['Name']}")
                st.write(f"- 🍽️ Prep Time: {meal['PrepTime']} minutes")
                st.write(f"- 🕒 Cook Time: {meal['CookTime']} minutes")
                st.write(f"- ⏰ Total Time: {meal['TotalTime']} minutes")
                st.write(f"- 😊 Difficulty: {meal['Difficulty']}")
                st.write(f"- 🍒 Ingredients: {meal['Ingredients']}")
                st.write(f"- 🤩 Instructions: {meal['Instructions']}")
            
            with col2:
                # Add favorite button
                if st.button("❤️ Add to Favorites", key=f"fav_{meal['RecipeID']}"):
                    try:
                        # Call the favorites API to save the meal
                        fav_response = requests.post(
                            "http://api:4000/f/favorites",
                            json={
                                "username": st.session_state['first_name'].lower(),
                                "recipe_id": meal['RecipeID']
                            }
                        )
                        if fav_response.status_code in [200, 201]:  # Accept both 200 (already favorited) and 201 (newly added)
                            st.success(fav_response.json()['message'])
                        else:
                            st.error("Failed to add to favorites. Please try again.")
                    except Exception as e:
                        st.error(f"Error adding to favorites: {str(e)}")
            
            st.markdown("---")
    else:
        st.info("No meals found.")

except requests.exceptions.RequestException as e:
    st.error(f"Could not connect to API: {e}")

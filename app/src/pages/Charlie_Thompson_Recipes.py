import streamlit as st
import requests

st.set_page_config(layout="wide")
st.title("📋 Explore All Meals")

# Add back button to sidebar
with st.sidebar:
    if st.button("🏠 Back to Home"):
        st.switch_page("pages/Charlie_Thompson.py")

# Check if user is logged in
if 'first_name' not in st.session_state:
    st.error("Please log in to view and favorite meals.")
    st.stop()

try:
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
                        fav_response = requests.post(
                            "http://api:4000/f/favorites",
                            json={
                                "username": st.session_state['first_name'].lower(),
                                "recipe_id": meal['RecipeID']
                            }
                        )
                        if fav_response.status_code == 201:
                            st.success("Added to favorites!")
                        else:
                            st.error("Failed to add to favorites. Please try again.")
                    except Exception as e:
                        st.error(f"Error adding to favorites: {str(e)}")
            
            st.markdown("---")
    else:
        st.info("No meals found.")

except requests.exceptions.RequestException as e:
    st.error(f"Could not connect to API: {e}")

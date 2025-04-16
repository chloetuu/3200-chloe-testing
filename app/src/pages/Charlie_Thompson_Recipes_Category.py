import streamlit as st
import requests
from modules.nav import SideBarLinks

# Set page config
st.set_page_config(layout="wide")

# Show appropriate sidebar links for the role of the currently logged in user
st.sidebar.image("assets/Charlie_pfp.jpeg", caption="fitwithcharlie", width=200)
SideBarLinks()

# Add back button to sidebar
with st.sidebar:
    if st.button("🏠 Back to Home"):
        st.switch_page("pages/Charlie_Thompson.py")

# Check if user is logged in
if 'first_name' not in st.session_state:
    st.error("Please log in to view and favorite meals.")
    st.stop()

# Title and user info
st.title(f"Welcome {st.session_state['first_name']}!")
st.write(f"***Bio:*** {st.session_state['bio']}")

# Add metrics
follower_count = 12000
following_count = 32

col_a, col_b = st.columns([0.5,0.5])
with col_a:
    st.metric(label="Followers", value=follower_count)
with col_b:
    st.metric(label="Following", value=following_count)

# Category selection
st.subheader("📋 Explore Meals by Category")
categories = ["All", "Breakfast", "Lunch", "Dinner", "Dessert", "Snack"]
selected_category = st.selectbox("Select a category", categories)

try:
    # Fetch meals from API
    response = requests.get("http://api:4000/m/meals")
    response.raise_for_status()
    meals = response.json()

    if meals:
        # Filter meals by category if a specific category is selected
        if selected_category != "All":
            meals = [meal for meal in meals if meal.get('MealType') == selected_category]

        # Display meals in a grid
        cols = st.columns(3)
        for i, meal in enumerate(meals):
            with cols[i % 3]:
                st.image(f"assets/{i % 8}.png", width=250)
                st.markdown(f"### {meal['Name']}")
                st.write(f"- 🍽️ Prep Time: {meal['PrepTime']} minutes")
                st.write(f"- 🕒 Cook Time: {meal['CookTime']} minutes")
                st.write(f"- ⏰ Total Time: {meal['TotalTime']} minutes")
                st.write(f"- 😊 Difficulty: {meal['Difficulty']}")
                
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
                
                # Add expander for ingredients and instructions
                with st.expander("View Details"):
                    st.write(f"- 🍒 Ingredients: {meal['Ingredients']}")
                    st.write(f"- 🤩 Instructions: {meal['Instructions']}")
                
                st.markdown("---")
    else:
        st.info("No meals found in this category.")

except requests.exceptions.RequestException as e:
    st.error(f"Could not connect to API: {e}")

# Add Tummi logo
col1, col2, col3 = st.columns([3, 1, 0.75])  
with col3:
    st.write('')     
    st.write('') 
    st.write('')     
    st.write('')
    st.write('')
    st.write('')
    st.write('')
    st.write('')
    st.write('')
    st.write('')
    st.image("assets/Tummi_logo.png", width=150, caption="Tummi") 
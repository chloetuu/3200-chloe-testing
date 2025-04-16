import streamlit as st
import requests
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
        # Add search and filter options
        col1, col2 = st.columns([2, 1])
        with col1:
            search = st.text_input("🔍 Search meals by name", "")
        with col2:
            difficulty = st.selectbox("Filter by difficulty", ["All", "Easy", "Medium", "Hard"])

        # Filter meals based on search and difficulty
        filtered_meals = meals
        if search:
            filtered_meals = [meal for meal in filtered_meals if search.lower() in meal['Name'].lower()]
        if difficulty != "All":
            filtered_meals = [meal for meal in filtered_meals if meal['Difficulty'] == difficulty]

        for meal in filtered_meals:
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
                            if fav_response.status_code in [200, 201]:
                                st.success(fav_response.json()['message'])
                            else:
                                st.error("Failed to add to favorites. Please try again.")
                        except Exception as e:
                            st.error(f"Error adding to favorites: {str(e)}")
    else:
        st.info("No meals found.")

except requests.exceptions.RequestException as e:
    st.error(f"Could not connect to API: {e}")

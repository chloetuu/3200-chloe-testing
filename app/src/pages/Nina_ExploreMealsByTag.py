import streamlit as st
import requests
from collections import defaultdict
from modules.nav import SideBarLinks

# Set page configuration
st.set_page_config(layout="wide", page_title="📋 Explore Meals by Tag")

# Display sidebar links
SideBarLinks()

st.title("📋 Explore Meals by Tag")

# --- Load Meals from Backend ---
def fetch_meals():
    try:
        response = requests.get("http://web-api:4000/m/meals")
        response.raise_for_status()
        return response.json()
    except Exception as e:
        st.error(f"Could not connect to meals API: {e}")
        return []

# --- Fetch Data ---
meals = fetch_meals()

if meals:
    # Extract all unique tags
    all_tags = set()
    for meal in meals:
        if meal.get('Tags'):
            tags = meal['Tags'].split(',')
            all_tags.update(tags)
    all_tags = sorted(list(all_tags))

    # --- Sidebar Filters ---
    with st.sidebar:
        st.header("🔍 Filter Meals")
        selected_tags = st.multiselect(
            "Select Tags", all_tags, default=all_tags
        )

    # --- Group meals by Tag ---
    grouped_meals = defaultdict(list)
    for meal in meals:
        if meal.get('Tags'):
            tags = meal['Tags'].split(',')
            for tag in tags:
                if tag in selected_tags:
                    grouped_meals[tag].append(meal)

    # --- Display Meals for Selected Tags ---
    for tag in selected_tags:
        if tag in grouped_meals:
            meal_list = grouped_meals[tag]
            st.markdown(f"## 🏷️ {tag}")
            for meal in meal_list:
                with st.expander(f"🍽️ {meal['Name']}"):
                    col1, col2 = st.columns([3, 1])
                    
                    with col1:
                        st.image(f"assets/{meal['RecipeID'] % 8}.png", width=350)
                        
                        # Display all tags for this meal
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
                                    "http://web-api:4000/f/favorites",
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
            st.markdown(f"### ⚠️ No meals found with tag: {tag}")

elif not meals:
    st.info("No meals found.") 
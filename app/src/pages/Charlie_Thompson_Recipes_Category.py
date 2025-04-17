import streamlit as st
import requests
from collections import defaultdict
from modules.nav import SideBarLinks

# Set page configuration
st.set_page_config(layout="wide", page_title="📋 Explore All Meals by Category")

# Display sidebar links
SideBarLinks()

st.title("📋 Explore Meals by Category")

# --- Load Categories from Backend ---
def fetch_categories():
    try:
        response = requests.get("http://api:4000/c/categories")
        response.raise_for_status()
        return [cat["Name"] for cat in response.json()]
    except Exception as e:
        st.sidebar.error(f"Error loading categories: {e}")
        return []

# --- Load Meals from Backend ---
def fetch_meals():
    try:
        response = requests.get("http://api:4000/m/meals")
        response.raise_for_status()
        return response.json()
    except Exception as e:
        st.error(f"Could not connect to meals API: {e}")
        return []

# --- Fetch Data ---
all_categories = fetch_categories()
meals = fetch_meals()

if meals and all_categories:
    # --- Sidebar Filters ---
    with st.sidebar:
        st.header("🔍 Filter Meals")
        selected_categories = st.multiselect(
            "Select Categories", all_categories, default=all_categories
        )

    # --- Group meals by Category ---
    grouped_meals = defaultdict(list)
    for meal in meals:
        category = meal.get("Category", "Uncategorized")
        grouped_meals[category].append(meal)

    # --- Display Meals for Selected Categories ---
    for category in selected_categories:
        if category in grouped_meals:
            meal_list = grouped_meals[category]
            st.markdown(f"## 🍽️ {category}")
            for i, meal in enumerate(meal_list):
                st.image(f"assets/{i % 8}.png", width=350)
                st.markdown(f"### {meal['Name']}")
                st.write(f"- 🍽️ Prep Time: {meal['PrepTime']} minutes")
                st.write(f"- 🕒 Cook Time: {meal['CookTime']} minutes")
                st.write(f"- ⏰ Total Time: {meal['TotalTime']} minutes")
                st.write(f"- 😊 Difficulty: {meal['Difficulty']}")
                st.write(f"- 🍒 Ingredients: {meal['Ingredients']}")
                st.write(f"- 🤩 Instructions: {meal['Instructions']}")
                st.markdown("---")
        else:
            st.markdown(f"### ⚠️ No meals found in category: {category}")

elif not meals:
    st.info("No meals found.") 
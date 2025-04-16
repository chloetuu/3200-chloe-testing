import streamlit as st
import requests
from collections import defaultdict

st.set_page_config(layout="wide", page_title="📋 Explore All Meals by Category")

# --- API CALL ---
try:
    response = requests.get("http://api:4000/m/meals")  # Update with your actual API
    response.raise_for_status()
    meals = response.json()

    if meals:
        # Group meals by Category
        grouped_meals = defaultdict(list)
        for meal in meals:
            category = meal.get("Category", "Uncategorized")
            grouped_meals[category].append(meal)

        # Collect all categories
        all_categories = sorted(grouped_meals.keys())

        # --- Sidebar Filters (MOVED UP HERE) ---
        with st.sidebar:
            st.header("🔍 Filter Meals")
            selected_categories = st.multiselect("Select Categories", all_categories, default=all_categories)

        # --- Main Page Title (after sidebar) ---
        st.title("📋 Explore Meals by Category")

        # --- Display Meals from Selected Categories ---
        for category in selected_categories:
            meal_list = grouped_meals[category]
            if meal_list:
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
        st.info("No meals found.")

except requests.exceptions.RequestException as e:
    st.error(f"Could not connect to API: {e}")

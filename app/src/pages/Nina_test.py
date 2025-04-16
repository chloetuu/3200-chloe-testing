import streamlit as st
import requests
from collections import defaultdict

st.set_page_config(layout="wide")
st.title("📋 Explore Meals by Category")

try:
    # 🔁 Call your Flask API endpoint
    response = requests.get("http://api:4000/m/meals")
    response.raise_for_status()
    meals = response.json()

    if meals:
        # Group meals by Category
        grouped_meals = defaultdict(list)
        for meal in meals:
            category = meal.get("Category", "Uncategorized")
            grouped_meals[category].append(meal)

        # Sort and list categories for dropdown
        categories = sorted(grouped_meals.keys())
        selected_category = st.selectbox("Choose a category to explore:", categories)

        # Display meals from the selected category
        st.markdown(f"## 🍽️ {selected_category}")
        for i, meal in enumerate(grouped_meals[selected_category]):
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

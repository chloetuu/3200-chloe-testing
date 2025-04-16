import streamlit as st
import requests
from collections import defaultdict

st.set_page_config(layout="wide")
st.title("📋 Explore All Meals by Category")

try:
    # 🔁 Call your Flask API endpoint
    response = requests.get("http://api:4000/m/meals")  # Update to match your setup
    response.raise_for_status()
    meals = response.json()

    if meals:
        # Group meals by Category
        grouped_meals = defaultdict(list)
        for meal in meals:
            category = meal.get("Category", "Uncategorized")
            grouped_meals[category].append(meal)

        # Display meals under each category
        for category, meal_list in grouped_meals.items():
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

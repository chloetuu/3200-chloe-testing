import streamlit as st
import requests

st.set_page_config(layout="wide")
st.title("📋 Explore All Meals")

try:
    # 🔁 Call your Flask API endpoint
    response = requests.get("http://api:4000/m/meals")  
    response.raise_for_status()

    meals = response.json()

    if meals:
        for i, meal in enumerate(meals):
            st.image(f"assets/{i % 2}.png", width=100)
            st.markdown(f"### {meal['Name']}")
            st.markdown(
                f"""
                - 🍽️ Prep Time: {meal['PrepTime']}
                - 🕒 Cook Time: {meal['CookTime']}
                - 📝 Instructions: {meal['Instructions']}
                """
            )
            st.markdown("---")
    else:
        st.info("No meals found.")

except requests.exceptions.RequestException as e:
    st.error(f"Could not connect to API: {e}")

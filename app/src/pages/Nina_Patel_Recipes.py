import streamlit as st
import requests

st.set_page_config(layout="wide")
st.title("📋 Explore All Meals")

try:
    # 🔁 Call your Flask API endpoint
    response = requests.get("http://localhost:8501/m/meals")  
    response.raise_for_status()

    meals = response.json()

    if meals:
        for meal in meals:
            st.markdown(f"### {meal['MealName']}")
            st.markdown(
                f"""
                - 👤 Added by: `{meal['Username']}`
                - 🍽️ Calories: {meal['Calories']}
                - 🕒 Meal Time: {meal['MealTime']}
                - 📝 Notes: {meal['Notes']}
                """
            )
            st.markdown("---")
    else:
        st.info("No meals found.")

except requests.exceptions.RequestException as e:
    st.error(f"Could not connect to API: {e}")

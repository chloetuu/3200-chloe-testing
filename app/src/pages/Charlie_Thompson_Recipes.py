import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout="wide")

st.title("📋 Blogs")

try:
    # 🔁 Call your Flask API endpoint
    response = requests.get("http://api:4000/b/blogs")  
    response.raise_for_status()

    blogs = response.json()

    if meals:
        for i, meal in enumerate(meals):
            st.image(f"assets/{i % 8}.png", width=350)
            st.markdown(f"### {meal['Name']}")
            st.write(f"- 🍽️ Title: {meal['Title']}")
            st.write(f"- 🕒 Publish Date: {meal['PublishDate']} minutes")
            st.write(f"- ⏰ Post: {meal['Content']}")
            st.write(f"- 😊 Username: {meal['Username']}")
            st.write(f"- 🍒 Blog ID: {meal['BlogID']}")
            st.write(f"- 🤩 Recipe ID: {meal['RecipeID']}")
            st.markdown("---")
    else:
        st.info("No meals found.")

except requests.exceptions.RequestException as e:
    st.error(f"Could not connect to API: {e}")

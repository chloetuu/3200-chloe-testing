import streamlit as st
import requests
import json

# Set the page title
st.title("Blogs")

# Function to fetch blogs from the API
def get_blogs():
    try:
        response = requests.get('http://web-api:4000/b/blogs')
        if response.status_code == 200:
            return response.json()
        else:
            st.error(f"Error fetching blogs: {response.status_code}")
            return []
    except Exception as e:
        st.error(f"Error connecting to the API: {str(e)}")
        return []

# Function to add a new blog
def add_blog(blog_data):
    try:
        response = requests.post('http://web-api:4000/b/blogs', json=blog_data)
        if response.status_code == 200:
            st.success("Blog added successfully!")
            return True
        else:
            st.error(f"Error adding blog: {response.status_code}")
            return False
    except Exception as e:
        st.error(f"Error connecting to the API: {str(e)}")
        return False

# Create a form for adding new blogs
with st.expander("Add New Blog"):
    with st.form("new_blog_form"):
        username = st.text_input("Username")
        meal_name = st.text_input("Meal Name")
        calories = st.number_input("Calories", min_value=0)
        meal_time = st.selectbox("Meal Time", ["Breakfast", "Lunch", "Dinner", "Snack"])
        notes = st.text_area("Notes")
        
        submit_button = st.form_submit_button("Add Blog")
        
        if submit_button:
            blog_data = {
                "username": username,
                "meal_name": meal_name,
                "calories": calories,
                "meal_time": meal_time,
                "notes": notes
            }
            if add_blog(blog_data):
                st.experimental_rerun()

# Display existing blogs
st.subheader("Existing Blogs")
blogs = get_blogs()

if blogs:
    for blog in blogs:
        with st.container():
            st.write(f"**Meal:** {blog.get('MealName', 'N/A')}")
            st.write(f"**By:** {blog.get('Username', 'Anonymous')}")
            st.write(f"**Calories:** {blog.get('Calories', 'N/A')}")
            st.write(f"**Meal Time:** {blog.get('MealTime', 'N/A')}")
            if blog.get('Notes'):
                st.write(f"**Notes:** {blog.get('Notes')}")
            st.divider()
else:
    st.info("No blogs found. Be the first to add one!")


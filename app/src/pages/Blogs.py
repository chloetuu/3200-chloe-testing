import streamlit as st
import requests
import json
from datetime import datetime

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
        title = st.text_input("Title")
        content = st.text_area("Content")
        
        submit_button = st.form_submit_button("Add Blog")
        
        if submit_button:
            blog_data = {
                "username": username,
                "title": title,
                "content": content
            }
            if add_blog(blog_data):
                st.experimental_rerun()

# Display existing blogs
st.subheader("Posted Blogs")
blogs = get_blogs()

if blogs:
    for blog in blogs:
        with st.container():
            # Format the publish date
            publish_date = blog.get('PublishDate')
            if publish_date:
                try:
                    date_obj = datetime.strptime(publish_date, '%Y-%m-%d %H:%M:%S')
                    formatted_date = date_obj.strftime('%B %d, %Y at %I:%M %p')
                except:
                    formatted_date = publish_date
            else:
                formatted_date = "Unknown date"
            
            # Display blog information
            st.write(f"**Title:** {blog.get('Title', 'Untitled')}")
            st.write(f"**By:** {blog.get('Username', 'Anonymous')}")
            st.write(f"**Published:** {formatted_date}")
            
            # Display content with proper formatting
            content = blog.get('Content', '')
            if content:
                st.write("**Content:**")
                st.write(content)
            
            # If there's a recipe ID, we can fetch and display the meal information
            recipe_id = blog.get('RecipeID')
            if recipe_id:
                try:
                    meal_response = requests.get(f'http://web-api:4000/m/meals/{recipe_id}')
                    if meal_response.status_code == 200:
                        meal = meal_response.json()
                        st.write("**Related Meal:**")
                        st.write(f"- Name: {meal.get('Name', 'N/A')}")
                        st.write(f"- Prep Time: {meal.get('PrepTime', 'N/A')} minutes")
                        st.write(f"- Cook Time: {meal.get('CookTime', 'N/A')} minutes")
                        st.write(f"- Total Time: {meal.get('TotalTime', 'N/A')} minutes")
                        st.write(f"- Difficulty: {meal.get('Difficulty', 'N/A')}")
                except:
                    st.write("Could not fetch meal information")
            
            st.divider()
else:
    st.info("No blogs found. Be the first to add one!")


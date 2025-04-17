import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

# Set page configuration
st.set_page_config(
    page_title="Charlie's Followers",
    page_icon="👥",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Initialize sidebar
with st.sidebar:
    # Add section header
    st.markdown("### Charlie's Pages")
    
    # Add navigation links directly
    st.page_link("pages/Charlie_Thompson.py", label="Home", icon="🏠")
    st.page_link("pages/Charlie_FavRecipes.py", label="Favorite Recipes", icon="❤️")
    st.page_link("pages/Charlie_Thompson_Recipes.py", label="Explore All Recipes", icon="🍔")
    st.page_link("pages/Charlie_Thompson_Recipes_Category.py", label="Explore Meals by Category", icon="🥗")
    st.page_link("pages/Blogs.py", label="Blogs", icon="📚")
    st.page_link("pages/Charlie_Followers.py", label="Followers", icon="👥")
    
    # Add separator
    st.markdown("---")
    
    # Add logout button
    if st.button("Logout"):
        del st.session_state["role"]
        del st.session_state["authenticated"]
        st.switch_page("Home.py")

# Main content
st.title("👥 Followers & Following")

# Fetch follower and following counts from the API
try:
    followers_response = requests.get("http://api:4000/u/users/fitwithcharlie/followers")
    following_response = requests.get("http://api:4000/u/users/fitwithcharlie/following")
    
    if followers_response.status_code == 200 and following_response.status_code == 200:
        followers = followers_response.json()['follower_count']
        following = following_response.json()['following_count']
    else:
        st.error("Error fetching follow counts")
        followers = 0
        following = 0
except Exception as e:
    st.error(f"Error fetching follow counts: {str(e)}")
    followers = 0
    following = 0

col_a, col_b = st.columns([0.5,0.5])
with col_a:
    st.metric(label="Followers", value=followers)
with col_b:
    st.metric(label="Following", value=following)

# Search functionality
search_query = st.text_input("Search users", placeholder="Enter username or bio...")

# Fetch all users for search
try:
    users_response = requests.get("http://api:4000/u/users")
    if users_response.status_code == 200:
        users = users_response.json()
        
        # Filter users based on search query
        if search_query:
            users = [user for user in users if 
                    search_query.lower() in user.get('username', '').lower() or 
                    search_query.lower() in user.get('bio', '').lower()]
        
        # Display users in a grid
        cols = st.columns(3)
        for i, user in enumerate(users):
            with cols[i % 3]:
                st.markdown(f"### {user.get('username', '')}")
                st.write(f"**Bio:** {user.get('bio', '')}")
                st.write(f"**Region:** {user.get('region', '')}")
                
                # Follow button
                if st.button("Follow", key=f"follow_{user.get('username', '')}"):
                    try:
                        response = requests.post(
                            "http://api:4000/u/users/follow",
                            json={
                                "follower_username": "fitwithcharlie",
                                "followee_username": user.get('username', '')
                            }
                        )
                        if response.status_code == 200:
                            st.success(f"Successfully followed {user.get('username', '')}!")
                        else:
                            st.error(f"Error following user: {response.text}")
                    except Exception as e:
                        st.error(f"Error following user: {str(e)}")
                
                st.markdown("---")
    else:
        st.error("Error fetching users")
except Exception as e:
    st.error(f"Error fetching users: {str(e)}") 
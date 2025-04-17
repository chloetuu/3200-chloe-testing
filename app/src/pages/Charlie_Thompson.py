import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

# Set page configuration
st.set_page_config(
    page_title="Charlie's Home",
    page_icon="🏠",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

# Check if user is logged in and all required session state variables are set
required_vars = ['authenticated', 'role', 'first_name', 'bio']
if not all(var in st.session_state for var in required_vars):
    st.error("Please log in to view this page.")
    st.switch_page("Home.py")

# Initialize sidebar
with st.sidebar:
    # Add section header
    st.markdown("### Charlie's Pages")
    
    # Add navigation links directly
    st.page_link("pages/Charlie_Thompson.py", label="Home", icon="🏠")
    st.page_link("pages/Charlie_FavRecipes.py", label="Favorite Recipes", icon="❤️")
    st.page_link("pages/Charlie_Thompson_Recipes.py", label="Explore All Recipes", icon="🍔")
    st.page_link("pages/Charlie_Thompson_Recipes_Category.py", label="Explore Meals by Tag", icon="🥗")
    st.page_link("pages/Blogs.py", label="Blogs", icon="📚")
    
    # Add separator
    st.markdown("---")
    
    # Add logout button
    if st.button("Logout"):
        # Clear all session state variables
        for key in list(st.session_state.keys()):
            del st.session_state[key]
        st.switch_page("Home.py")

# Main content
st.title(f"Welcome {st.session_state['first_name']}.")

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

st.write('')
st.write('')
st.write(f"***Bio:*** {st.session_state['bio']}")

# Add Tummi logo
col1, col2, col3 = st.columns([3, 1, 0.75])  
with col3:
    st.write('')     
    st.write('') 
    st.write('')     
    st.write('')
    st.write('')
    st.write('')
    st.write('')
    st.write('')
    st.write('')
    st.write('')
    st.image("assets/Tummi_logo.png", width=150, caption="Tummi")

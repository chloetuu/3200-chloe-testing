import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

# Set page configuration
st.set_page_config(
    page_title="Charlie's Home",
    page_icon="🏠",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Initialize sidebar
with st.sidebar:
    # Add section header
    st.markdown("### Charlie's Pages")
    
    # Add navigation links directly
    st.page_link("pages/Charlie_FavRecipes.py", label="Favorite Recipes", icon="❤️")
    st.page_link("pages/Charlie_Thompson_Recipes.py", label="Explore All Recipes", icon="🍔")
    st.page_link("pages/Charlie_Thompson_Recipes_Category.py", label="Explore Meals by Category", icon="🥗")
    st.page_link("pages/Blogs.py", label="Blogs", icon="📚")
    
    # Add separator
    st.markdown("---")
    
    # Add logout button
    if st.button("Logout"):
        del st.session_state["role"]
        del st.session_state["authenticated"]
        st.switch_page("Home.py")

# Main content
st.title(f"Welcome {st.session_state['first_name']}.")

# Adds the followers and following count 
follower_count = 12000
following_count = 32

col_a, col_b = st.columns([0.5,0.5])
with col_a:
    st.metric(label="Followers", value=follower_count)
with col_b:
    st.metric(label="Following", value=following_count)

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

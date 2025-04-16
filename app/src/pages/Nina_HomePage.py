import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')



# Show appropriate sidebar links for the role of the currently logged in user
st.sidebar.image("assets/nina_patel_pfp.jpg", caption="@soccermom123", width=150)

SideBarLinks()


st.title(f"Welcome {st.session_state['first_name']}.")

# Adds the followers and following count 
follower_count = 128
following_count = 67

col_a, col_b = st.columns([0.5,0.5])
with col_a:
    st.metric(label="Followers", value=follower_count)
with col_b:
    st.metric(label="Following", value=following_count)

st.write('')
st.write('')
st.write(f"***Bio:*** {st.session_state['bio']}")


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

# Add favorite button
if st.button("❤️ Add to Favorites", key=f"fav_{meal['RecipeID']}"):
    try:
        response = requests.post(
            "http://api:4000/f/favorites",
            json={
                "username": st.session_state['first_name'].lower(),
                "recipe_id": meal['RecipeID']
            }
        )
        if response.status_code in [200, 201]:  # Accept both 200 (already favorited) and 201 (newly added)
            st.success(response.json()['message'])
        else:
            st.error("Failed to add to favorites. Please try again.")
    except Exception as e:
        st.error(f"Error adding to favorites: {str(e)}")




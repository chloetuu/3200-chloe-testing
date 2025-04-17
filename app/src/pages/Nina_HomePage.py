import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome {st.session_state['first_name']}.")

# Get follower and following counts from the API
try:
    # Get follower count
    follower_response = requests.get(f"http://api:4000/u/users/{st.session_state['first_name'].lower()}/followers")
    follower_response.raise_for_status()
    follower_count = follower_response.json()['follower_count']

    # Get following count
    following_response = requests.get(f"http://api:4000/u/users/{st.session_state['first_name'].lower()}/following")
    following_response.raise_for_status()
    following_count = following_response.json()['following_count']
except Exception as e:
    st.error(f"Error fetching follow counts: {e}")
    follower_count = 0
    following_count = 0

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




import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Initialize Bio if it doesn't exist yet
if 'bio' not in st.session_state:
    st.session_state['bio'] = 'This is a default bio.'


# Show appropriate sidebar links for the role of the currently logged in user
st.sidebar.image("assets/Charlie_pfp.jpeg", caption="Charlie Thompson", width=200)
SideBarLinks()

st.title(f"Welcome {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write(f"### Bio: {st.session_state['bio']}")

if st.button('Favorite Recipes', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/01_World_Bank_Viz.py')

if st.button('Explore All Recipes', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/02_Map_Demo.py')

if st.button('Blog', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/02_Map_Demo.py')


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
st.write(f"### Bio: {st.session_state['bio']}")



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

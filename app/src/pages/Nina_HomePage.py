import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Initialize Bio if it doesn't exist yet
if 'bio' not in st.session_state:
    st.session_state['bio'] = 'This is a default bio.'


# Show appropriate sidebar links for the role of the currently logged in user
st.sidebar.image("assets/nina_patel_pfp.jpg", caption="Nina Patel", width=150)
SideBarLinks()

st.title(f"Welcome {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write(f"### Bio: {st.session_state['bio']}")

if st.button('Recipes', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/01_World_Bank_Viz.py')

if st.button('View World Map Demo', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/02_Map_Demo.py')
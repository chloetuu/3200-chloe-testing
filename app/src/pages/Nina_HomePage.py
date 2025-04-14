import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Initialize Bio if it doesn't exist yet
if 'Bio' not in st.session_state:
    st.session_state['Bio'] = 'This is a default bio.'


# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Nina Patel, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write(f"### bio: {st.session_state['Bio']}")

if st.button('Recipes', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/01_World_Bank_Viz.py')

if st.button('View World Map Demo', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/02_Map_Demo.py')
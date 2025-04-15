import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('API Dashboard', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/Jade_Api_Dashboard.py')

if st.button('Time Series Graph', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/Jade_Time.py')


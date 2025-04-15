import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

# Show sidebar links for James' role
SideBarLinks()

# Welcome message
st.title(f"Welcome, {st.session_state['first_name']}.")
st.write("")
st.write("")
st.write("### What would you like to do today?")

# Navigation buttons
if st.button('Analytics Dashboard', 
             type='primary',
             use_container_width=True):
    st.switch_page('pages/James_AnalyticsDashboard.py')  # Adjust if your filename is different

if st.button('Data Editing Page', 
             type='primary',
             use_container_width=True):
    st.switch_page('pages/James_DataEditing.py')  # Adjust if your filename is different

import logging
import streamlit as st
from modules.nav import SideBarLinks

# Set up logging
logger = logging.getLogger(__name__)

# Streamlit page config
st.set_page_config(page_title="James - Home", layout='wide')

# Sidebar links for James Okoro
SideBarLinks()

# Check for session state (fallback if not set)
if "first_name" not in st.session_state:
    st.session_state["first_name"] = "James"

# Welcome message
st.title(f"Welcome, {st.session_state['first_name']}.")
st.markdown("### What would you like to do today?")

# Navigation buttons
col1, col2 = st.columns(2)

with col1:
    if st.button('📊 Analytics Dashboard', use_container_width=True):
        st.switch_page('pages/James_AnalyticsDashboard.py')  # Make sure filename matches exactly

with col2:
    if st.button('📝 Data Editing Page', use_container_width=True):
        st.switch_page('pages/James_DataEditing.py')

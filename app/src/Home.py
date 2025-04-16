##################################################
# This is the main/entry-point file for the 
# sample application for your project
##################################################

# Set up basic logging infrastructure
import logging
logging.basicConfig(format='%(filename)s:%(lineno)s:%(levelname)s -- %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

# import the main streamlit library as well
# as SideBarLinks function from src/modules folder
import streamlit as st
from modules.nav import SideBarLinks

# streamlit supports regular and wide layout (how the controls
# are organized/displayed on the screen).
st.set_page_config(
    page_title="Tummi - Home",
    page_icon="🍽️",
    layout="wide"
)

# Initialize session state
if 'authenticated' not in st.session_state:
    st.session_state['authenticated'] = False

# Display sidebar
SideBarLinks(show_home=True)

# ***************************************************
#    The major content of this page
# ***************************************************

# Main content
st.title("Welcome to Tummi! 👋")
st.write("Please select a user to log in:")

# User selection buttons
col1, col2, col3, col4 = st.columns(4)

with col1:
    if st.button("Nina", use_container_width=True):
        st.session_state['authenticated'] = True
        st.session_state['first_name'] = 'Nina'
        st.session_state['role'] = 'user'
        st.session_state['bio'] = 'Food enthusiast and home cook'
        st.switch_page("pages/Nina_HomePage.py")

with col2:
    if st.button("Jade", use_container_width=True):
        st.session_state['authenticated'] = True
        st.session_state['first_name'] = 'Jade'
        st.session_state['role'] = 'user'
        st.session_state['bio'] = 'Developer and food lover'
        st.switch_page("pages/Jade_HomePage.py")

with col3:
    if st.button("James", use_container_width=True):
        st.session_state['authenticated'] = True
        st.session_state['first_name'] = 'James'
        st.session_state['role'] = 'user'
        st.session_state['bio'] = 'Data analyst and recipe explorer'
        st.switch_page("pages/James_HomePage.py")

with col4:
    if st.button("Charlie", use_container_width=True):
        st.session_state['authenticated'] = True
        st.session_state['first_name'] = 'Charlie'
        st.session_state['role'] = 'user'
        st.session_state['bio'] = 'Fitness enthusiast and healthy eating advocate'
        st.switch_page("pages/Charlie_Thompson.py")

# Display Tummi logo
st.image("assets/tummi_logo.png", width=300)


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
import requests

# streamlit supports reguarl and wide layout (how the controls
# are organized/displayed on the screen).
st.set_page_config(layout = 'wide')

# If a user is at this page, we assume they are not 
# authenticated.  So we change the 'authenticated' value
# in the streamlit session_state to false. 
st.session_state['authenticated'] = False

# Use the SideBarLinks function from src/modules/nav.py to control
# the links displayed on the left-side panel. 
# IMPORTANT: ensure src/.streamlit/config.toml sets
# showSidebarNavigation = false in the [client] section
SideBarLinks(show_home=True)

# ***************************************************
#    The major content of this page
# ***************************************************

# set the title of the page and provide a simple prompt. 
logger.info("Loading the Home page of the app")
st.title('Tummi')
st.write('\n\n')
st.write('### HI! As which user would you like to log in?')


# For each of the user personas for which we are implementing
# functionality, we put a button on the screen that the user 
# can click to MIMIC logging in as that mock user. 

if st.button("Act as Nina, a Soccer Mom", 
            type = 'primary', 
            use_container_width=True):
    try:
        # Fetch Nina's data from the API
        firstname_response = requests.get("http://localhost:4000/u/users/soccermom123/firstname")
        bio_response = requests.get("http://localhost:4000/u/users/soccermom123/bio")
        
        if firstname_response.status_code == 200 and bio_response.status_code == 200:
            st.session_state['authenticated'] = True
            st.session_state['role'] = 'Stay at home mother'
            st.session_state['first_name'] = firstname_response.json()['first_name']
            st.session_state['bio'] = bio_response.json()['bio']
            logger.info("Logging in as Nina Patel (User)")
            st.switch_page('pages/Nina_HomePage.py')
        else:
            st.error("Error fetching user data. Please try again.")
    except Exception as e:
        st.error(f"Error connecting to API: {str(e)}")

if st.button('Act as Jade, Backend Developer', 
            type = 'primary', 
            use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'backend_developer'
    st.session_state['first_name'] = 'Jade'
    st.switch_page('pages/Jade_Home.py')

if st.button("Act as James, a Data Analyst",
             type='primary',
             use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'Data Analyst'
    st.session_state['first_name'] = 'James'
    st.session_state['bio'] = 'As a data analyst, I uncover trends in nutrition engagement and flagged ingredients to improve community health tools.'
    logger.info("Logging in as James Okoro (User)")
    st.switch_page("pages/James_Homepage.py")

if st.button("Act as Charlie, an Influencer",
             type = 'primary',
             use_container_width=True):
    try:
        firstname_response = requests.get("http://localhost:4000/u/users/fitwithcharlie/firstname")
        bio_response = requests.get("http://localhost:4000/u/users/fitwithcharlie/bio")
        
        if firstname_response.status_code == 200 and bio_response.status_code == 200:
            st.session_state['authenticated'] = True
            st.session_state['role'] = 'Follow my fitness journey'
            st.session_state['first_name'] = firstname_response.json()['first_name']
            st.session_state['bio'] = bio_response.json()['bio']
            logger.info("Logging in as Charlie Thompson (User)")
            st.switch_page('pages/Charlie_Thompson.py')
        else:
            st.error("Error fetching user data. Please try again.")
    except Exception as e:
        st.error(f"Error connecting to API: {str(e)}")

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

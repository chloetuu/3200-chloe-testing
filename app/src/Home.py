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
    # when user clicks the button, they are now considered authenticated
    st.session_state['authenticated'] = True
    # we set the role of the current user
    st.session_state['role'] = 'Stay at home mother'
    # we add the first name of the user (so it can be displayed on 
    st.session_state['first_name'] = 'Nina'
    # setting the bio of the users
    st.session_state['bio'] = 'I am a stay at home mom who has 3 children who have different dietary restrictions! Follow me to follow my journey :)'
    # finally, we ask streamlit to switch to another page, in this case, the 
    # landing page for this particular user type
    logger.info("Logging in as Nina Patel (User)")
    st.switch_page('pages/Nina_HomePage.py')


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
    # user is now authenticated
    st.session_state['authenticated'] = True
    # define the user role
    st.session_state['role'] = 'Data Analyst'
    # user's first name
    st.session_state['first_name'] = 'James'
    # user bio
    st.session_state['bio'] = 'As a data analyst, I uncover trends in nutrition engagement and flagged ingredients to improve community health tools.'
    # log the action
    logger.info("Logging in as James Okoro (User)")
    # go to the actual user page
    st.switch_page("pages/James_Homepage.py")

if st.button("Act as Charlie, an Influencer",
             type = 'primary',
             use_container_width=True):
    # when user clicks the button, they are now considered authenticated
    st.session_state['authenticated'] = True
    # we set the role of the current user
    st.session_state['role'] = 'Follow my fitness journey'
    # we add the first name of the user (so it can be displayed on subsequent pages).
    st.session_state['first_name'] = 'Charlie'
    # setting the bio of the users
    st.session_state['bio'] = 'Fueled by flavor, powered by gains. Follow me on Instagram and Youtube @fitwithcharlie for more content'
    # finally, we ask streamlit to switch to another page, in this case, the landing page for this particular user type
    logger.info("Logging in as Charlie Thompson (User)")
    st.switch_page('pages/Charlie_Thompson.py')

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

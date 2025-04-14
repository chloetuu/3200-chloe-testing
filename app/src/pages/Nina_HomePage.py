import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Initialize Bio if it doesn't exist yet
if 'bio' not in st.session_state:
    st.session_state['bio'] = 'This is a default bio.'


# Show appropriate sidebar links for the role of the currently logged in user
st.sidebar.image("assets/nina_patel_pfp.jpg", caption="@soccermom123", width=150)
# we add the username under the profile picture 

SideBarLinks()

st.title(f"Welcome {st.session_state['first_name']}.")
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




import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

# Setup default session state
if 'bio' not in st.session_state:
    st.session_state['bio'] = 'I’m passionate about improving community health through better food data.'

if 'first_name' not in st.session_state:
    st.session_state['first_name'] = 'James'

# Sidebar
st.sidebar.image("assets/James_pfp.jpeg", caption="James Okoro", width=200)
SideBarLinks()

# Main page
st.title(f"Welcome {st.session_state['first_name']}")
st.subheader("🔍 Public Health Insights Dashboard")
st.write(f"### Bio: {st.session_state['bio']}")

# Editable Bio Section
with st.expander("Edit Bio"):
    new_bio = st.text_area("Your Bio", st.session_state['bio'])
    if st.button("Update Bio"):
        st.session_state['bio'] = new_bio
        st.success("Bio updated!")

st.markdown("---")

# Filters for demographic analysis
st.subheader("📊 Filter User Trends")
col1, col2, col3 = st.columns(3)
with col1:
    age_group = st.selectbox("Age Group", ["All", "18-25", "26-40", "41-60", "60+"])
with col2:
    region = st.selectbox("Region", ["All", "Northeast", "Midwest", "South", "West"])
with col3:
    restriction = st.selectbox("Dietary Restriction", ["All", "Vegan", "Vegetarian", "Gluten-Free", "None"])

if st.button("Apply Filters"):
    st.success(f"Filters applied: Age {age_group}, Region {region}, Restriction {restriction}")
    # This is where you'd call filtered graphs or data functions

st.markdown("---")

# Navigation Buttons
col4, col5 = st.columns(2)

with col4:
    if st.button('📈 View Engagement Dashboard', use_container_width=True):
        st.switch_page('pages/03_Engagement_Dashboard.py')

with col5:
    if st.button('🌍 Ingredient Flag Map', use_container_width=True):
        st.switch_page('pages/04_Ingredient_Map.py')

# Export Functionality
st.markdown("#### 📤 Export")
if st.button("Download PDF Summary"):
    st.info("Your PDF download will begin soon. (Feature in development)")

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
st.title("📋 Explore All Meals")
SideBarLinks()

st.header("My Recipes")

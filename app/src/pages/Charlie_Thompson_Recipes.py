import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks()

st.header("My Recipes")

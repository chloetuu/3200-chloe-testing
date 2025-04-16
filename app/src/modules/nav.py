# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has function to add certain functionality to the left side bar of the app

import streamlit as st
from streamlit_option_menu import option_menu
import requests
import json
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Initialize session state for authentication if not already present
if 'authenticated' not in st.session_state:
    st.session_state['authenticated'] = False

#### ------------------------ General ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


def AboutPageNav():
    st.sidebar.page_link("pages/30_About.py", label="About", icon="🧠")

def FavoriteRecipes(): 
    st.sidebar.page_link("pages/Nina_FavRecipes.py", label="Favorite Recipes", icon="❤️")

def ExploreRecipes():
    st.sidebar.page_link("pages/Nina_Patel_Recipes.py", label="Explore All Recipes", icon="🍔")

def CharlieFavoriteRecipes(): 
    st.sidebar.page_link("pages/Charlie_FavRecipes.py", label="Favorite Recipes", icon="❤️")

def CharlieExploreRecipes():
    st.sidebar.page_link("pages/Charlie_Thompson_Recipes.py", label="Explore All Recipes", icon="🍔")

def CharlieExploreByCategory():
    st.sidebar.page_link("pages/Charlie_Thompson_Recipes_Category.py", label="Explore Meals by Category", icon="🥗")

def testNina():
    st.sidebar.page_link("pages/Nina_test.py", label="Categories", icon="😅")

#### ---------------------- Specific to Charlie ----------------------------

def Blogs(): 
    st.sidebar.page_link("pages/Blogs.py", label="Blogs", icon="📚")


#### ------------------------ Examples for Role of pol_strat_advisor ------------------------
def PolStratAdvHomeNav():
    st.sidebar.page_link(
        "pages/00_Pol_Strat_Home.py", label="Political Strategist Home", icon="👤"
    )


def Profile_Page():
    st.sidebar.page_link(
        "pages/01_Profile_Page.py", label="Profile Page", icon="🏦"
    )


def Recipe_Page():
    st.sidebar.page_link("pages/02_Recipe_Page.py", label="Map Demonstration", icon="🗺️")


## ------------------------ Examples for Role of usaid_worker ------------------------
def BackendNav():
    st.sidebar.page_link(
        "pages/Jade_Home.py", label="Backend Developer Home", icon="👤"
    )

def ApiDashboardNav():
    st.sidebar.page_link("pages/Jade_Api_Dashboard.py", label="API Dashboard", icon="🛜")


def GraphNav():
    st.sidebar.page_link(
        "pages/Jade_Time.py", label="Time Series Graph", icon="📈"
    )


def ClassificationNav():
    st.sidebar.page_link(
        "pages/13_Classification.py", label="Classification Demo", icon="🌺"
    )

#### ------------------------ Specific to James ------------------------
def JamesNav():
    st.sidebar.page_link("pages/James_Homepage.py", label="James Home", icon="📊")
    
def AnalystBoard():    
    st.sidebar.page_link("pages/James_AnalyticsDashboard.py", label="Analytics Dashboard", icon="📈")

def DataEditing():    
    st.sidebar.page_link("pages/James_DataEditing.py", label="Data Editing", icon="🛠️")


#### ------------------------ System Admin Role ------------------------
def AdminPageNav():
    st.sidebar.page_link("pages/20_Admin_Home.py", label="System Admin", icon="🖥️")
    st.sidebar.page_link(
        "pages/21_ML_Model_Mgmt.py", label="ML Model Management", icon="🏢"
    )


# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=False):
    """Display sidebar links based on user authentication and role."""
    with st.sidebar:
        if st.session_state.get('authenticated'):
            # Display profile picture and user info
            if st.session_state.get('first_name') == 'Charlie':
                st.image("assets/Charlie_pfp.jpeg", caption="fitwithcharlie", width=200)
            elif st.session_state.get('first_name') == 'Nina':
                st.image("assets/Nina_pfp.jpeg", caption="ninapatel", width=200)
            
            st.write(f"### {st.session_state.get('first_name', 'User')}'s Pages")
            
            # Add navigation links based on user role
            if st.session_state.get('first_name') == 'Charlie':
                st.page_link("pages/Charlie_Thompson.py", label="Favorite Recipes", icon="❤️")
                st.page_link("pages/Charlie_Thompson_Recipes.py", label="Explore All Recipes", icon="🍔")
                st.page_link("pages/Charlie_Thompson_Recipes_Category.py", label="Explore Meals by Category", icon="🥗")
                st.page_link("pages/Charlie_Thompson_Blogs.py", label="Blogs", icon="📚")
            elif st.session_state.get('first_name') == 'Nina':
                st.page_link("pages/Nina_HomePage.py", label="Favorite Recipes", icon="❤️")
                st.page_link("pages/Nina_test.py", label="Explore All Recipes", icon="🍔")
                st.page_link("pages/Nina_test.py", label="Explore Meals by Category", icon="🥗")
                st.page_link("pages/Nina_Blogs.py", label="Blogs", icon="📚")
            
            # Add logout button
            if st.button("Logout", type="primary"):
                st.session_state['authenticated'] = False
                st.rerun()
        else:
            if show_home:
                st.page_link("Home.py", label="Home", icon="🏠")
            

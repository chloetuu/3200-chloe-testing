# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has function to add certain functionality to the left side bar of the app

import streamlit as st
import requests


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
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in.
    """

    # If there is no logged in user, redirect to the Home (Landing) page
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")

    if show_home:
        # Show the Home page link (the landing page)
        HomeNav()

    # Show the other page navigators depending on the users' role.
    if st.session_state["authenticated"]:
        # Display user profile picture based on who is logged in
        if st.session_state["first_name"].lower() == "nina":
            st.sidebar.image("assets/nina_patel_pfp.jpg", caption="@soccermom123", width=150)
        elif st.session_state["first_name"].lower() == "charlie":
            st.sidebar.image("assets/Charlie_pfp.jpeg", caption="fitwithcharlie", width=200)
        elif st.session_state["first_name"].lower() == "jade":
            st.sidebar.image("assets/jade_pfp.jpg", caption="@jade_dev", width=150)
        elif st.session_state["first_name"].lower() == "james":
            st.sidebar.image("assets/james_pfp.jpg", caption="@james_analyst", width=150)

        # If the user role is usaid worker, show the Api Testing page
        if st.session_state["role"] == "backend_developer":
            BackendNav()
            ApiDashboardNav()
            GraphNav()

        # If the user is an administrator, give them access to the administrator pages
        if st.session_state["role"] == "administrator":
            AdminPageNav()

        # if the user is Nina, show all her pages in the sidebar
        if st.session_state["first_name"].lower() == "nina":
            st.sidebar.markdown("---")
            st.sidebar.markdown("### Nina's Pages")
            st.sidebar.page_link("pages/Nina_HomePage.py", label="Home", icon="🏠")
            st.sidebar.page_link("pages/Nina_FavRecipes.py", label="Favorite Recipes", icon="❤️")
            st.sidebar.page_link("pages/Nina_Patel_Recipes.py", label="Explore All Recipes", icon="🍔")
            st.sidebar.page_link("pages/Nina_test.py", label="Explore Meals by Category", icon="🥳")

        # if the user is Charlie, show their Favorite Recipes page 
        if st.session_state["first_name"].lower() == "charlie":
            st.sidebar.markdown("---")
            st.sidebar.markdown("### Charlie's Pages")
            # Add all four navigation links for Charlie
            st.sidebar.page_link("pages/Charlie_FavRecipes.py", label="Favorite Recipes", icon="❤️")
            st.sidebar.page_link("pages/Charlie_Thompson_Recipes.py", label="Explore All Recipes", icon="🍔")
            st.sidebar.page_link("pages/Charlie_Thompson_Recipes_Category.py", label="Explore Meals by Category", icon="🥗")
            st.sidebar.page_link("pages/Blogs.py", label="Blogs", icon="📚")

        # if the user is James, show his dashboard links
        if st.session_state["first_name"].lower() == "james":
            JamesNav()
            AnalystBoard()
            DataEditing()
            

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        st.sidebar.markdown("---")
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")
            

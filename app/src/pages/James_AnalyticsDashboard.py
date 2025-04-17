import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
import pandas as pd
import plotly.express as px
from datetime import datetime
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Analytics Dashboard")

"""
This dashboard displays key metrics and analytics for the Tummy application, including user interactions, meal popularity, and system performance.
"""

# Create tabs for different analytics sections
tab1, tab2, tab3, tab4 = st.tabs(["User Analytics", "Meal Analytics", "Interaction Analytics", "System Performance"])

# User Analytics Tab
with tab1:
    st.subheader("User Analytics")
    
    # Fetch user data
    user_data = []
    try:
        response = requests.get('http://localhost:4000/u/users/analytics')
        if response.status_code == 200:
            user_data = response.json().get('data', {})
        else:
            st.error(f"Error fetching user data: {response.status_code}")
    except Exception as e:
        st.error(f"Error connecting to API: {str(e)}")
    
    if user_data:
        # Create columns for different visualizations
        col1, col2 = st.columns(2)
        
        with col1:
            # Region distribution
            region_df = pd.DataFrame(user_data['region_counts'])
            fig_region = px.pie(
                region_df,
                values='count',
                names='Region',
                title="User Distribution by Region",
                color_discrete_sequence=px.colors.qualitative.Set3
            )
            st.plotly_chart(fig_region, use_container_width=True)
        
        with col2:
            # Activity level distribution
            activity_df = pd.DataFrame(user_data['activity_counts'])
            fig_activity = px.bar(
                activity_df,
                x='ActivityLevel',
                y='count',
                title="User Distribution by Activity Level",
                color='ActivityLevel',
                color_discrete_sequence=px.colors.qualitative.Set3
            )
            st.plotly_chart(fig_activity, use_container_width=True)
        
        # Age distribution
        age_df = pd.DataFrame(user_data['age_distribution'])
        fig_age = px.bar(
            age_df,
            x='age_group',
            y='count',
            title="User Age Distribution",
            color='age_group',
            color_discrete_sequence=px.colors.qualitative.Set3
        )
        st.plotly_chart(fig_age, use_container_width=True)

# Meal Analytics Tab
with tab2:
    st.subheader("Meal Analytics")
    
    # Fetch meal data
    meal_data = []
    try:
        response = requests.get('http://localhost:4000/m/analytics')
        if response.status_code == 200:
            meal_data = response.json().get('data', {})
        else:
            st.error(f"Error fetching meal data: {response.status_code}")
    except Exception as e:
        st.error(f"Error connecting to API: {str(e)}")
    
    if meal_data:
        col1, col2 = st.columns(2)
        
        with col1:
            # Difficulty distribution
            difficulty_df = pd.DataFrame(meal_data['difficulty_counts'])
            fig_difficulty = px.pie(
                difficulty_df,
                values='count',
                names='Difficulty',
                title="Meal Distribution by Difficulty",
                color_discrete_sequence=px.colors.qualitative.Set3
            )
            st.plotly_chart(fig_difficulty, use_container_width=True)
        
        with col2:
            # Tag popularity
            tag_df = pd.DataFrame(meal_data['tag_counts'])
            fig_tags = px.bar(
                tag_df,
                x='TagName',
                y='count',
                title="Tag Popularity",
                color='TagName',
                color_discrete_sequence=px.colors.qualitative.Set3
            )
            st.plotly_chart(fig_tags, use_container_width=True)
        
        # Top meals
        top_meals_df = pd.DataFrame(meal_data['top_meals'])
        fig_top_meals = px.bar(
            top_meals_df,
            x='Name',
            y='ViewCount',
            title="Top 10 Most Viewed Meals",
            color='Name',
            color_discrete_sequence=px.colors.qualitative.Set3
        )
        st.plotly_chart(fig_top_meals, use_container_width=True)

# Interaction Analytics Tab
with tab3:
    st.subheader("Interaction Analytics")
    
    # Fetch interaction data
    interaction_data = []
    try:
        response = requests.get('http://localhost:4000/i/interactions/analytics')
        if response.status_code == 200:
            interaction_data = response.json().get('data', {})
        else:
            st.error(f"Error fetching interaction data: {response.status_code}")
    except Exception as e:
        st.error(f"Error connecting to API: {str(e)}")
    
    if interaction_data:
        col1, col2 = st.columns(2)
        
        with col1:
            # Interaction type distribution
            type_df = pd.DataFrame(interaction_data['type_counts'])
            fig_type = px.pie(
                type_df,
                values='count',
                names='InteractionType',
                title="Interaction Type Distribution",
                color_discrete_sequence=px.colors.qualitative.Set3
            )
            st.plotly_chart(fig_type, use_container_width=True)
        
        with col2:
            # Interactions over time
            time_df = pd.DataFrame(interaction_data['time_series'])
            time_df['date'] = pd.to_datetime(time_df['date'])
            fig_time = px.line(
                time_df,
                x='date',
                y='count',
                title="Interactions Over Time",
                markers=True
            )
            st.plotly_chart(fig_time, use_container_width=True)

# System Performance Tab
with tab4:
    st.subheader("System Performance")
    
    # Fetch log data
    log_data = []
    try:
        response = requests.get('http://localhost:4000/l/logs/analytics')
        if response.status_code == 200:
            log_data = response.json().get('data', {})
        else:
            st.error(f"Error fetching log data: {response.status_code}")
    except Exception as e:
        st.error(f"Error connecting to API: {str(e)}")
    
    if log_data:
        col1, col2 = st.columns(2)
        
        with col1:
            # Severity distribution
            severity_df = pd.DataFrame(log_data['severity_counts'])
            fig_severity = px.pie(
                severity_df,
                values='count',
                names='SeverityLevel',
                title="Log Severity Distribution",
                color_discrete_sequence=px.colors.qualitative.Set3
            )
            st.plotly_chart(fig_severity, use_container_width=True)
        
        with col2:
            # Alert type distribution
            alert_df = pd.DataFrame(log_data['alert_counts'])
            fig_alerts = px.bar(
                alert_df,
                x='Type',
                y='count',
                title="Alert Type Distribution",
                color='Type',
                color_discrete_sequence=px.colors.qualitative.Set3
            )
            st.plotly_chart(fig_alerts, use_container_width=True)
        
        # Logs over time
        time_df = pd.DataFrame(log_data['time_series'])
        time_df['date'] = pd.to_datetime(time_df['date'])
        fig_time = px.line(
            time_df,
            x='date',
            y='count',
            title="System Logs Over Time",
            markers=True
        )
        st.plotly_chart(fig_time, use_container_width=True) 
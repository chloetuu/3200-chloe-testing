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
        col1, col2 = st.columns(2)
        
        with col1:
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
    st.info("Meal analytics data is not yet available. This feature will be implemented in a future update.")
    
    # Placeholder data for demonstration
    difficulty_data = {
        'Difficulty': ['Easy', 'Medium', 'Hard'],
        'count': [40, 35, 25]
    }
    tag_data = {
        'TagName': ['Vegetarian', 'Quick', 'Healthy', 'Dinner', 'Lunch'],
        'count': [30, 25, 20, 15, 10]
    }
    top_meals_data = {
        'Name': ['Pasta Primavera', 'Chicken Stir Fry', 'Vegetable Curry', 'Beef Stew', 'Salmon Bowl'],
        'ViewCount': [150, 120, 100, 80, 60]
    }
    
    col1, col2 = st.columns(2)
    
    with col1:
        difficulty_df = pd.DataFrame(difficulty_data)
        fig_difficulty = px.pie(
            difficulty_df,
            values='count',
            names='Difficulty',
            title="Meal Distribution by Difficulty (Sample Data)",
            color_discrete_sequence=px.colors.qualitative.Set3
        )
        st.plotly_chart(fig_difficulty, use_container_width=True)
    
    with col2:
        tag_df = pd.DataFrame(tag_data)
        fig_tags = px.bar(
            tag_df,
            x='TagName',
            y='count',
            title="Tag Popularity (Sample Data)",
            color='TagName',
            color_discrete_sequence=px.colors.qualitative.Set3
        )
        st.plotly_chart(fig_tags, use_container_width=True)
    
    top_meals_df = pd.DataFrame(top_meals_data)
    fig_top_meals = px.bar(
        top_meals_df,
        x='Name',
        y='ViewCount',
        title="Top 5 Most Viewed Meals (Sample Data)",
        color='Name',
        color_discrete_sequence=px.colors.qualitative.Set3
    )
    st.plotly_chart(fig_top_meals, use_container_width=True)

# Interaction Analytics Tab
with tab3:
    st.subheader("Interaction Analytics")
    st.info("Interaction analytics data is not yet available. This feature will be implemented in a future update.")
    
    # Placeholder data for demonstration
    type_data = {
        'InteractionType': ['View', 'Search', 'Save', 'Share'],
        'count': [45, 30, 15, 10]
    }
    time_data = {
        'date': pd.date_range(start='2024-01-01', periods=30, freq='D'),
        'count': [10, 12, 15, 8, 20, 18, 22, 25, 30, 28,
                 32, 35, 30, 28, 25, 22, 20, 18, 15, 12,
                 10, 8, 12, 15, 18, 20, 22, 25, 28, 30]
    }
    
    col1, col2 = st.columns(2)
    
    with col1:
        type_df = pd.DataFrame(type_data)
        fig_type = px.pie(
            type_df,
            values='count',
            names='InteractionType',
            title="Interaction Type Distribution (Sample Data)",
            color_discrete_sequence=px.colors.qualitative.Set3
        )
        st.plotly_chart(fig_type, use_container_width=True)
    
    with col2:
        time_df = pd.DataFrame(time_data)
        fig_time = px.line(
            time_df,
            x='date',
            y='count',
            title="Interactions Over Time (Sample Data)",
            markers=True
        )
        st.plotly_chart(fig_time, use_container_width=True)

# System Performance Tab
with tab4:
    st.subheader("System Performance")
    st.info("System performance data is not yet available. This feature will be implemented in a future update.")
    
    # Placeholder data for demonstration
    severity_data = {
        'SeverityLevel': ['Info', 'Warning', 'Error', 'Critical'],
        'count': [60, 20, 15, 5]
    }
    alert_data = {
        'Type': ['System', 'Security', 'Performance', 'User'],
        'count': [40, 30, 20, 10]
    }
    log_time_data = {
        'date': pd.date_range(start='2024-01-01', periods=30, freq='D'),
        'count': [50, 55, 60, 45, 70, 65, 80, 75, 90, 85,
                 100, 95, 90, 85, 80, 75, 70, 65, 60, 55,
                 50, 45, 55, 60, 65, 70, 75, 80, 85, 90]
    }
    
    col1, col2 = st.columns(2)
    
    with col1:
        severity_df = pd.DataFrame(severity_data)
        fig_severity = px.pie(
            severity_df,
            values='count',
            names='SeverityLevel',
            title="Log Severity Distribution (Sample Data)",
            color_discrete_sequence=px.colors.qualitative.Set3
        )
        st.plotly_chart(fig_severity, use_container_width=True)
    
    with col2:
        alert_df = pd.DataFrame(alert_data)
        fig_alerts = px.bar(
            alert_df,
            x='Type',
            y='count',
            title="Alert Type Distribution (Sample Data)",
            color='Type',
            color_discrete_sequence=px.colors.qualitative.Set3
        )
        st.plotly_chart(fig_alerts, use_container_width=True)
    
    time_df = pd.DataFrame(log_time_data)
    fig_time = px.line(
        time_df,
        x='date',
        y='count',
        title="System Logs Over Time (Sample Data)",
        markers=True
    )
    st.plotly_chart(fig_time, use_container_width=True)

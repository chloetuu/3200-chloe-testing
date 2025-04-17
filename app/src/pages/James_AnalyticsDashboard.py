import streamlit as st
import requests
import pandas as pd
import plotly.express as px
from datetime import datetime
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.set_page_config(page_title="Analytics Dashboard", layout="wide")

st.write("# Analytics Dashboard")
st.markdown("""
This dashboard displays key metrics and analytics for the Tummi application, including user interactions, meal popularity, and system performance.
""")

st.markdown("**Last updated:** March 25th, 2025")

# Sidebar Filters
with st.sidebar:
    st.header("Filters")
    age_group = st.selectbox("Age Group", [">18", "18–24", "25–34", "35–44", "45–54", "55+"])
    region = st.selectbox("Region", ["Northeast", "South", "Midwest", "West"])
    timeframe = st.selectbox("Timeframe", ["Day", "Week", "Month", "6 Months", "Year"])
    st.button("Apply Filters")

# Create tabs for different analytics sections
tab1, tab2, tab3, tab4 = st.tabs(["User Analytics", "Meal Analytics", "Interaction Analytics", "System Performance"])

# User Analytics Tab
with tab1:
    st.subheader("User Analytics")
    try:
        response = requests.get('http://localhost:4000/u/users/analytics')
        user_data = response.json().get('data', {}) if response.status_code == 200 else {}
    except Exception as e:
        st.error(f"Error fetching user data: {str(e)}")
        user_data = {}

    if user_data:
        col1, col2 = st.columns(2)

        with col1:
            region_df = pd.DataFrame(user_data['region_counts'])
            fig_region = px.pie(region_df, values='count', names='Region', title="User Distribution by Region",
                                color_discrete_sequence=px.colors.qualitative.Set3)
            st.plotly_chart(fig_region, use_container_width=True)

        with col2:
            activity_df = pd.DataFrame(user_data['activity_counts'])
            fig_activity = px.bar(activity_df, x='ActivityLevel', y='count',
                                  title="User Distribution by Activity Level", color='ActivityLevel',
                                  color_discrete_sequence=px.colors.qualitative.Set3)
            st.plotly_chart(fig_activity, use_container_width=True)

        age_df = pd.DataFrame(user_data['age_distribution'])
        fig_age = px.bar(age_df, x='age_group', y='count', title="User Age Distribution",
                         color='age_group', color_discrete_sequence=px.colors.qualitative.Set3)
        st.plotly_chart(fig_age, use_container_width=True)

# Meal Analytics Tab
with tab2:
    st.subheader("Meal Analytics")
    try:
        response = requests.get('http://localhost:4000/m/meals/analytics')
        meal_data = response.json().get('data', {}) if response.status_code == 200 else {}
    except Exception as e:
        st.error(f"Error fetching meal data: {str(e)}")
        meal_data = {}

    if meal_data:
        col1, col2 = st.columns(2)

        with col1:
            # Popular categories grouped bar chart
            categories = ['Dinner', 'Lunch', 'Healthy', 'Quick']
            views = [140000, 125000, 120000, 100000]
            saves = [120000, 115000, 100000, 75000]
            cat_df = pd.DataFrame({
                'Category': categories * 2,
                'Count': views + saves,
                'Type': ['Views'] * 4 + ['Saves'] * 4
            })
            fig_popular = px.bar(cat_df, x='Category', y='Count', color='Type', barmode='group',
                                  title="Popular Categories (Top 4)", color_discrete_sequence=px.colors.qualitative.Set2)
            st.plotly_chart(fig_popular, use_container_width=True)

        with col2:
            tag_df = pd.DataFrame(meal_data['tag_counts'])
            fig_tags = px.bar(tag_df, x='TagName', y='count', title="Tag Popularity",
                              color='TagName', color_discrete_sequence=px.colors.qualitative.Set3)
            st.plotly_chart(fig_tags, use_container_width=True)

        top_meals_df = pd.DataFrame(meal_data['top_meals'])
        fig_top = px.bar(top_meals_df, x='Name', y='ViewCount', title="Top 10 Most Viewed Meals",
                         color='Name', color_discrete_sequence=px.colors.qualitative.Set3)
        st.plotly_chart(fig_top, use_container_width=True)

# Interaction Analytics Tab
with tab3:
    st.subheader("Interaction Analytics")
    try:
        response = requests.get('http://localhost:4000/i/interactions/analytics')
        interaction_data = response.json().get('data', {}) if response.status_code == 200 else {}
    except Exception as e:
        st.error(f"Error fetching interaction data: {str(e)}")
        interaction_data = {}

    if interaction_data:
        col1, col2 = st.columns(2)

        with col1:
            type_df = pd.DataFrame(interaction_data['type_counts'])
            fig_type = px.pie(type_df, values='count', names='InteractionType',
                              title="Interaction Type Distribution",
                              color_discrete_sequence=px.colors.qualitative.Set3)
            st.plotly_chart(fig_type, use_container_width=True)

        with col2:
            time_df = pd.DataFrame(interaction_data['time_series'])
            time_df['date'] = pd.to_datetime(time_df['date'])
            fig_time = px.line(time_df, x='date', y='count', title="Interactions Over Time", markers=True)
            st.plotly_chart(fig_time, use_container_width=True)

# System Performance Tab
with tab4:
    st.subheader("System Performance")
    try:
        response = requests.get('http://localhost:4000/l/logs/analytics')
        log_data = response.json().get('data', {}) if response.status_code == 200 else {}
    except Exception as e:
        st.error(f"Error fetching log data: {str(e)}")
        log_data = {}

    if log_data:
        col1, col2 = st.columns(2)

        with col1:
            severity_df = pd.DataFrame(log_data['severity_counts'])
            fig_severity = px.pie(severity_df, values='count', names='SeverityLevel',
                                  title="Log Severity Distribution", color_discrete_sequence=px.colors.qualitative.Set3)
            st.plotly_chart(fig_severity, use_container_width=True)

        with col2:
            alert_df = pd.DataFrame(log_data['alert_counts'])
            fig_alerts = px.bar(alert_df, x='Type', y='count', title="Alert Type Distribution",
                                color='Type', color_discrete_sequence=px.colors.qualitative.Set3)
            st.plotly_chart(fig_alerts, use_container_width=True)

        time_df = pd.DataFrame(log_data['time_series'])
        time_df['date'] = pd.to_datetime(time_df['date'])
        fig_log_time = px.line(time_df, x='date', y='count', title="System Logs Over Time", markers=True)
        st.plotly_chart(fig_log_time, use_container_width=True)

# Top Recipes Section
st.markdown("---")
st.subheader("Top Recipes")
col1, col2, col3 = st.columns(3)

with col1:
    st.markdown("**★ 1. Acai Smoothie Bowl**")
    st.image("https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/A%C3%A7a%C3%AD_na_Tigela.jpg/640px-A%C3%A7a%C3%AD_na_Tigela.jpg", width=120)
    st.button("View details", key="acai")

with col2:
    st.markdown("**2. Tiramisu Cake**")
    st.image("https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Tiramisu_-_Raffaele_Diomede.jpg/640px-Tiramisu_-_Raffaele_Diomede.jpg", width=120)
    st.button("View details", key="tiramisu")

with col3:
    st.markdown("**3. Steak & Eggs**")
    st.image("https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Steak_and_eggs_0001.jpg/640px-Steak_and_eggs_0001.jpg", width=120)
    st.button("View details", key="steak")

# Export Button
st.markdown("---")
st.download_button("📄 Export as PDF/PNG", data="Report data placeholder", file_name="analytics_export.pdf")

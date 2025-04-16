import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from datetime import datetime, timedelta
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# System Performance Dashboard")

"""
This dashboard provides time-based analysis of system errors and performance metrics, helping backend developers identify patterns and potential issues.
"""

# Fetch data from API
data = []
try:
    response = requests.get('http://api:4000/l/log')
    if response.status_code == 200:
        data = response.json()
    else:
        st.error(f"Error fetching data: {response.status_code}")
        data = []
except Exception as e:
    st.error(f"Error connecting to API: {str(e)}")
    data = []

if data:
    # Convert to DataFrame
    df = pd.DataFrame(data)
    
    # Convert timestamp to datetime
    df['Timestamp'] = pd.to_datetime(df['Timestamp'])
    
    # Add time-based columns for analysis
    df['hour'] = df['Timestamp'].dt.hour
    df['day_of_week'] = df['Timestamp'].dt.day_name()
    df['date'] = df['Timestamp'].dt.date
    
    # Create tabs for different views
    tab1, tab2, tab3 = st.tabs(["Hourly Analysis", "Weekly Patterns", "Performance Metrics"])
    
    with tab1:
        st.subheader("Error Distribution by Hour")
        # Group by hour and severity
        hourly_data = df.groupby(['hour', 'SeverityLevel']).size().reset_index(name='count')
        
        # Create stacked bar chart
        fig_hourly = px.bar(
            hourly_data,
            x='hour',
            y='count',
            color='SeverityLevel',
            title="Errors by Hour of Day",
            labels={'hour': 'Hour of Day', 'count': 'Number of Errors'},
            barmode='stack'
        )
        st.plotly_chart(fig_hourly, use_container_width=True)
        
        # Show peak error hours
        peak_hours = df.groupby('hour').size().sort_values(ascending=False).head(3)
        st.write("Peak Error Hours:")
        for hour, count in peak_hours.items():
            st.write(f"- Hour {hour}: {count} errors")
    
    with tab2:
        st.subheader("Weekly Error Patterns")
        # Group by day of week and severity
        weekly_data = df.groupby(['day_of_week', 'SeverityLevel']).size().reset_index(name='count')
        
        # Order days of week
        day_order = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
        weekly_data['day_of_week'] = pd.Categorical(weekly_data['day_of_week'], categories=day_order, ordered=True)
        weekly_data = weekly_data.sort_values('day_of_week')
        
        # Create line chart
        fig_weekly = px.line(
            weekly_data,
            x='day_of_week',
            y='count',
            color='SeverityLevel',
            title="Errors by Day of Week",
            markers=True
        )
        st.plotly_chart(fig_weekly, use_container_width=True)
        
        # Show error trends
        st.subheader("Error Trends")
        col1, col2 = st.columns(2)
        with col1:
            st.write("Most Error-Prone Days:")
            day_counts = df.groupby('day_of_week').size().sort_values(ascending=False)
            for day, count in day_counts.items():
                st.write(f"- {day}: {count} errors")
        with col2:
            st.write("Error Rate by Severity:")
            severity_counts = df['SeverityLevel'].value_counts()
            for severity, count in severity_counts.items():
                st.write(f"- {severity}: {count} errors")
    
    with tab3:
        st.subheader("Performance Metrics")
        
        # Calculate error rate over time
        df['date'] = pd.to_datetime(df['date'])
        error_rate = df.groupby('date').size().reset_index(name='count')
        
        # Create moving average
        error_rate['moving_avg'] = error_rate['count'].rolling(window=7).mean()
        
        # Create time series plot
        fig_performance = go.Figure()
        fig_performance.add_trace(go.Scatter(
            x=error_rate['date'],
            y=error_rate['count'],
            name='Daily Errors',
            mode='lines+markers'
        ))
        fig_performance.add_trace(go.Scatter(
            x=error_rate['date'],
            y=error_rate['moving_avg'],
            name='7-Day Moving Average',
            line=dict(dash='dash')
        ))
        fig_performance.update_layout(
            title="Error Rate Over Time",
            xaxis_title="Date",
            yaxis_title="Number of Errors"
        )
        st.plotly_chart(fig_performance, use_container_width=True)
        
        # Show performance metrics
        st.subheader("Key Metrics")
        col1, col2 = st.columns(2)
        with col1:
            st.metric("Total Errors", len(df))
            st.metric("Average Daily Errors", round(error_rate['count'].mean(), 1))
        with col2:
            st.metric("Peak Daily Errors", error_rate['count'].max())
            st.metric("Current Trend", 
                     "Increasing" if error_rate['moving_avg'].iloc[-1] > error_rate['moving_avg'].iloc[-2] 
                     else "Decreasing")
    
    # Display raw data in an expandable section
    with st.expander("View Raw Data"):
        st.dataframe(df)
else:
    st.warning("No data available to display. Please check the API connection.")
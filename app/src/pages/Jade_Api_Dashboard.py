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

st.write("# Error Logs Dashboard")

"""
This dashboard displays error logs from the application, including visualizations of severity levels and temporal patterns.
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
    
    # Rename columns to match our expected format
    df = df.rename(columns={
        'LogID': 'id',
        'Timestamp': 'timestamp',
        'ErrorMessage': 'message',
        'SeverityLevel': 'severity',
        'Source': 'source',
        'Details': 'details'
    })
    
    # Convert timestamp to datetime
    df['timestamp'] = pd.to_datetime(df['timestamp'])
    
    # Create two columns for layout
    col1, col2 = st.columns(2)
    
    with col1:
        st.subheader("Severity Distribution")
        # Create pie chart for severity levels
        severity_counts = df['severity'].value_counts()
        fig_severity = px.pie(
            values=severity_counts.values,
            names=severity_counts.index,
            title="Distribution of Error Severity Levels",
            color_discrete_sequence=px.colors.qualitative.Set3
        )
        st.plotly_chart(fig_severity, use_container_width=True)
        
        # Display basic statistics
        st.subheader("Statistics")
        st.write(f"Total Logs: {len(df)}")
        st.write(f"Most Common Severity: {severity_counts.index[0]} ({severity_counts.values[0]} logs)")
        st.write(f"Time Range: {df['timestamp'].min().strftime('%Y-%m-%d %H:%M')} to {df['timestamp'].max().strftime('%Y-%m-%d %H:%M')}")
    
    with col2:
        st.subheader("Logs Over Time")
        # Create bar chart for logs per day
        df['date'] = df['timestamp'].dt.date
        daily_counts = df.groupby('date').size().reset_index(name='count')
        fig_temporal = px.bar(
            daily_counts,
            x='date',
            y='count',
            title="Number of Logs per Day",
            labels={'date': 'Date', 'count': 'Number of Logs'}
        )
        st.plotly_chart(fig_temporal, use_container_width=True)
    
    # Display raw data in an expandable section
    with st.expander("View Raw Data"):
        st.dataframe(df)
else:
    st.warning("No data available to display. Please check the API connection.")
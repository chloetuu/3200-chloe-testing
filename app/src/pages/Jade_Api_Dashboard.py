import streamlit as st
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import requests
from datetime import datetime, timedelta

# Set page config
st.set_page_config(
    page_title="Log Entry Dashboard",
    page_icon="📊",
    layout="wide"
)

# API endpoints
BASE_URL = "http://localhost:4000"
LOGS_ENDPOINT = f"{BASE_URL}/l/log"
STATS_ENDPOINT = f"{BASE_URL}/l/log/stats"

@st.cache_data(ttl=300)  # Cache for 5 minutes
def fetch_logs():
    response = requests.get(LOGS_ENDPOINT)
    if response.status_code == 200:
        return pd.DataFrame(response.json())
    return pd.DataFrame()

@st.cache_data(ttl=300)
def fetch_stats():
    response = requests.get(STATS_ENDPOINT)
    if response.status_code == 200:
        return response.json()
    return {"severity": [], "trends": []}

# Title
st.title("📊 Log Entry Dashboard")

# Fetch data
logs_df = fetch_logs()
stats = fetch_stats()

# Metrics
col1, col2, col3, col4 = st.columns(4)
with col1:
    st.metric("Total Log Entries", len(logs_df))
with col2:
    error_count = len(logs_df[logs_df['SeverityLevel'] == 'ERROR'])
    st.metric("Error Count", error_count)
with col3:
    warning_count = len(logs_df[logs_df['SeverityLevel'] == 'WARNING'])
    st.metric("Warning Count", warning_count)
with col4:
    avg_issues = logs_df['IssueCount'].mean() if 'IssueCount' in logs_df else 0
    st.metric("Avg Issues per Log", f"{avg_issues:.2f}")

# Tabs for different visualizations
tab1, tab2, tab3 = st.tabs(["Severity Distribution", "Error Trends", "Log Details"])

with tab1:
    # Severity Distribution Pie Chart
    severity_df = pd.DataFrame(stats['severity'])
    if not severity_df.empty:
        fig = px.pie(severity_df, values='count', names='SeverityLevel', 
                    title='Log Severity Distribution')
        st.plotly_chart(fig, use_container_width=True)
    else:
        st.info("No severity data available")

with tab2:
    # Error Trends Line Chart
    trends_df = pd.DataFrame(stats['trends'])
    if not trends_df.empty:
        trends_df['date'] = pd.to_datetime(trends_df['date'])
        fig = px.line(trends_df, x='date', y='count', 
                     title='Log Entries Over Time')
        st.plotly_chart(fig, use_container_width=True)
    else:
        st.info("No trend data available")

with tab3:
    # Log Details Table with Filters
    st.subheader("Log Details")
    
    # Filters
    col1, col2 = st.columns(2)
    with col1:
        severity_filter = st.multiselect(
            "Filter by Severity",
            options=logs_df['SeverityLevel'].unique() if not logs_df.empty else [],
            default=[]
        )
    with col2:
        source_filter = st.multiselect(
            "Filter by Source",
            options=logs_df['Source'].unique() if not logs_df.empty else [],
            default=[]
        )
    
    # Apply filters
    filtered_df = logs_df.copy()
    if severity_filter:
        filtered_df = filtered_df[filtered_df['SeverityLevel'].isin(severity_filter)]
    if source_filter:
        filtered_df = filtered_df[filtered_df['Source'].isin(source_filter)]
    
    # Display table
    st.dataframe(
        filtered_df,
        column_config={
            "LogID": "Log ID",
            "Timestamp": "Timestamp",
            "ErrorMessage": "Error Message",
            "SeverityLevel": "Severity",
            "Source": "Source",
            "Details": "Details",
            "IssueCount": "Issue Count"
        },
        use_container_width=True
    ) 
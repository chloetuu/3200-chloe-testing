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
This dashboard provides time-based analysis of system errors, performance metrics, and alert management.
"""

# Fetch data from API
data = []
alerts_data = []
try:
    # Fetch log data
    log_response = requests.get('http://api:4000/l/log')
    if log_response.status_code == 200:
        data = log_response.json()
    else:
        st.error(f"Error fetching log data: {log_response.status_code}")
        data = []

    # Fetch alerts data
    alerts_response = requests.get('http://api:4000/a/alerts')
    if alerts_response.status_code == 200:
        alerts_data = alerts_response.json()
    else:
        st.error(f"Error fetching alerts data: {alerts_response.status_code}")
        alerts_data = []
except Exception as e:
    st.error(f"Error connecting to API: {str(e)}")
    data = []
    alerts_data = []

# Create tabs for different views
tab1, tab2, tab3, tab4 = st.tabs(["Performance Metrics", "Hourly Analysis", "Weekly Patterns", "Alert Management"])

if data:
    # Convert to DataFrame
    df = pd.DataFrame(data)
    
    # Convert timestamp to datetime
    df['Timestamp'] = pd.to_datetime(df['Timestamp'])
    
    # Add time-based columns for analysis
    df['hour'] = df['Timestamp'].dt.hour
    df['day_of_week'] = df['Timestamp'].dt.day_name()
    df['date'] = df['Timestamp'].dt.date

    with tab1:
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
    
    with tab2:
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
    
    with tab3:
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

else:
    st.warning("No log data available to display. Please check the API connection.")

# Alert Management Tab
with tab4:
    st.subheader("Alert Management")
    
    if alerts_data:
        # Convert alerts to DataFrame
        alerts_df = pd.DataFrame(alerts_data)
        
        # Convert timestamp to datetime, handling potential format issues
        try:
            alerts_df['Timestamp'] = pd.to_datetime(alerts_df['Timestamp'], format='%Y-%m-%d %H:%M:%S')
        except:
            try:
                alerts_df['Timestamp'] = pd.to_datetime(alerts_df['Timestamp'], format='%Y-%m-%dT%H:%M:%S')
            except:
                alerts_df['Timestamp'] = pd.to_datetime(alerts_df['Timestamp'], errors='coerce')
        
        # Filter options
        col1, col2, col3 = st.columns(3)
        with col1:
            alert_type = st.selectbox("Filter by Alert Type", ['All'] + list(alerts_df['Type'].unique()))
        with col2:
            severity_level = st.selectbox("Filter by Severity", ['All'] + list(alerts_df['SeverityLevel'].unique()))
        with col3:
            # Handle missing Status field
            if 'Status' in alerts_df.columns:
                status = st.selectbox("Filter by Status", ['All'] + list(alerts_df['Status'].unique()))
            else:
                status = 'All'
                st.selectbox("Filter by Status", ['All'], disabled=True)
        
        # Apply filters
        filtered_alerts = alerts_df.copy()
        if alert_type != 'All':
            filtered_alerts = filtered_alerts[filtered_alerts['Type'] == alert_type]
        if severity_level != 'All':
            filtered_alerts = filtered_alerts[filtered_alerts['SeverityLevel'] == severity_level]
        if status != 'All' and 'Status' in filtered_alerts.columns:
            filtered_alerts = filtered_alerts[filtered_alerts['Status'] == status]
        
        # Display alerts
        st.write(f"Showing {len(filtered_alerts)} alerts")
        
        # Alert metrics
        col1, col2, col3 = st.columns(3)
        with col1:
            st.metric("Total Alerts", len(alerts_df))
        with col2:
            if 'Status' in alerts_df.columns:
                st.metric("Open Alerts", len(alerts_df[alerts_df['Status'] == 'OPEN']))
            else:
                st.metric("Open Alerts", "N/A")
        with col3:
            st.metric("Critical Alerts", len(alerts_df[alerts_df['SeverityLevel'] == 'CRITICAL']))
        
        # Display alerts in a table
        display_columns = ['AlertID', 'Type', 'Timestamp', 'SeverityLevel', 'AssignedTo', 'Source']
        if 'Status' in alerts_df.columns:
            display_columns.insert(4, 'Status')
        st.dataframe(
            filtered_alerts[display_columns],
            use_container_width=True
        )
        
        # Alert details and actions
        st.subheader("Alert Details")
        selected_alert_id = st.selectbox("Select Alert ID", filtered_alerts['AlertID'].tolist())
        
        if selected_alert_id:
            selected_alert = filtered_alerts[filtered_alerts['AlertID'] == selected_alert_id].iloc[0]
            
            col1, col2 = st.columns(2)
            with col1:
                st.write("**Alert Details:**")
                st.write(f"Type: {selected_alert['Type']}")
                st.write(f"Timestamp: {selected_alert['Timestamp']}")
                st.write(f"Severity: {selected_alert['SeverityLevel']}")
                if 'Status' in selected_alert:
                    st.write(f"Status: {selected_alert['Status']}")
                st.write(f"Assigned To: {selected_alert['AssignedTo']}")
            
            with col2:
                st.write("**Log Details:**")
                st.write(f"Source: {selected_alert['Source']}")
                st.write(f"Error Message: {selected_alert['ErrorMessage']}")
                st.write(f"Details: {selected_alert['Details']}")
            
            # Alert actions
            st.subheader("Alert Actions")
            col1, col2 = st.columns(2)
            with col1:
                if 'Status' in selected_alert:
                    new_status = st.selectbox("Update Status", ['OPEN', 'IN_PROGRESS', 'RESOLVED', 'CLOSED'])
                    if st.button("Update Status"):
                        try:
                            response = requests.put(
                                f'http://api:4000/a/alerts/{selected_alert_id}/status',
                                json={'status': new_status}
                            )
                            if response.status_code == 200:
                                st.success("Status updated successfully")
                            else:
                                st.error(f"Failed to update status: {response.status_code}")
                        except Exception as e:
                            st.error(f"Error updating status: {str(e)}")
                else:
                    st.write("Status updates not available")
            
            with col2:
                if st.button("Delete Alert", type="secondary"):
                    try:
                        response = requests.delete(f'http://api:4000/a/alerts/{selected_alert_id}')
                        if response.status_code == 200:
                            st.success("Alert deleted successfully")
                        else:
                            st.error(f"Failed to delete alert: {response.status_code}")
                    except Exception as e:
                        st.error(f"Error deleting alert: {str(e)}")
    else:
        st.warning("No alerts available to display. Please check the API connection.")
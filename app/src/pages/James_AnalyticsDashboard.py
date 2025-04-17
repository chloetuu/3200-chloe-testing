import streamlit as st
import pandas as pd
import plotly.express as px
import requests

st.title("📊 Interaction Analytics Dashboard")

# Fetch interaction data from Flask API
interaction_data = {}
try:
    response = requests.get("http://api:4000/m/interactions/analytics")
    if response.status_code == 200:
        interaction_data = response.json().get("data", {})
    else:
        st.error(f"Error fetching interaction data: {response.status_code}")
except Exception as e:
    st.error(f"Error connecting to API: {str(e)}")

# Display charts if data exists
if interaction_data:
    col1, col2 = st.columns(2)

    with col1:
        st.subheader("Interaction Type Distribution")
        type_df = pd.DataFrame(interaction_data["type_counts"])
        fig_type = px.pie(
            type_df,
            values="count",
            names="InteractionType",
            title="Interaction Types",
            color_discrete_sequence=px.colors.qualitative.Set3
        )
        st.plotly_chart(fig_type, use_container_width=True)

    with col2:
        st.subheader("Interactions Over Time")
        time_df = pd.DataFrame(interaction_data["time_series"])
        time_df["date"] = pd.to_datetime(time_df["date"])
        fig_time = px.line(
            time_df,
            x="date",
            y="count",
            title="Interactions Over Time",
            markers=True
        )
        st.plotly_chart(fig_time, use_container_width=True)

    st.subheader("Top 10 Interacted Meals")
    top_df = pd.DataFrame(interaction_data["top_meals"])
    fig_top = px.bar(
        top_df,
        x="Name",
        y="count",
        title="Top Meals by Interactions",
        color="Name",
        color_discrete_sequence=px.colors.qualitative.Set3
    )
    st.plotly_chart(fig_top, use_container_width=True)
else:
    st.warning("No interaction data available.")

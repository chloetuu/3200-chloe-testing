import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import datetime
st.set_page_config(layout = 'wide')

# Display the appropriate sidebar links for the role of the logged in user
SideBarLinks()

st.title('API Dashboard')

# create a 2 column layout
col1, col2, col3 = st.columns(3)

with col1:
    st.subheader("Website")
    
    # Sample data
    labels_website = ["Good", "Moderate", "Bad"]
    values_website = [115, 22, 44] 

    fig1, ax1 = plt.subplots()
    
    # Create a "donut" by setting wedgeprops width
    # and also a white circle in the middle
    wedges, texts, autotexts = ax1.pie(
        values_website,
        labels=labels_website,
        autopct="%1.1f%%",
        startangle=140,
        wedgeprops={"width": 0.4},
    )
    # Draw a circle at the center for donut shape
    centre_circle = plt.Circle((0, 0), 0.70, fc="white")
    fig1.gca().add_artist(centre_circle)
    ax1.axis("equal")
    
    st.pyplot(fig1)

with col2:
    st.subheader("Databases")
    
    # Sample data
    labels_db = ["Good", "Moderate", "Bad"]
    values_db = [280, 31, 8]  # example: 280 "good", 31 "moderate", 8 "bad"
    
    fig2, ax2 = plt.subplots()
    wedges, texts, autotexts = ax2.pie(
        values_db,
        labels=labels_db,
        autopct="%1.1f%%",
        startangle=140,
        wedgeprops={"width": 0.4},
    )
    centre_circle = plt.Circle((0, 0), 0.70, fc="white")
    fig2.gca().add_artist(centre_circle)
    ax2.axis("equal")
    
    st.pyplot(fig2)


with col3:
    st.subheader("API Downtime")

    # Let's simulate some "downtime minutes" over a few days
    days_back = 7
    date_range = [datetime.date.today() - datetime.timedelta(days=x) for x in range(days_back)][::-1]
    downtime_data = np.random.randint(low=0, high=60, size=days_back)  # random 0-60 minutes downtime

    # Convert to a DataFrame
    downtime_df = pd.DataFrame({"Date": date_range, "Downtime (min)": downtime_data})
    downtime_df.set_index("Date", inplace=True)

    # Use Streamlit's built-in line_chart
    st.line_chart(downtime_df)

st.subheader("User Reported Issues")


issues_data = {
    "Date": ["3/20", "3/18", "3/14"],
    "Issue": ["Cannot Save Recipe", "Log-in Issue", "Account Deletion Requests"],
}
issues_df = pd.DataFrame(issues_data)

# Display as a table
st.table(issues_df)
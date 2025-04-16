import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

st.set_page_config(page_title="Analytics Dashboard", layout="wide")

# Title + Last Updated
st.title("📊 Analytics Dashboard")
st.markdown("**Last updated:** March 25th, 2025")

# Back nav in sidebar
st.sidebar.page_link("pages/James_Homepage.py", label="⬅️ Back to James Homepage")  # ← Update to actual filename!

# Sidebar Filters
with st.sidebar:
    st.header("Filters")
    age_group = st.selectbox("Age Group", [">18", "18–24", "25–34", "35–44", "45–54", "55+"])
    region = st.selectbox("Region", ["Northeast", "South", "Midwest", "West"])
    timeframe = st.selectbox("Timeframe", ["Day", "Week", "Month", "6 Months", "Year"])
    st.button("Apply Filters")

# Layout: 3 columns (Bar chart | Line chart | Top Recipes)
col1, col2, col3 = st.columns([2, 2, 1.5])

# --- Popular Categories Bar Chart ---
with col1:
    st.subheader("Popular Categories (Top 4)")
    categories = ['Dinner', 'Lunch', 'Healthy', 'Quick']
    views = [140000, 125000, 120000, 100000]
    saves = [120000, 115000, 100000, 75000]

    fig, ax = plt.subplots()
    x = range(len(categories))
    ax.bar(x, views, width=0.4, label='Views', align='center', alpha=0.7)
    ax.bar([p + 0.4 for p in x], saves, width=0.4, label='Saves', align='center', alpha=0.7)
    ax.set_xticks([p + 0.2 for p in x])
    ax.set_xticklabels(categories)
    ax.set_ylabel("Views/Saves")
    ax.legend()
    st.pyplot(fig)

# --- Overall Engagement Line Chart ---
with col2:
    st.subheader("Overall Engagement Over Time")
    timeline = list(range(10))
    line_views = [1000, 3000, 5000, 2000, 2500, 6000, 7000, 8000, 10000, 12000]
    line_saves = [500, 1500, 3000, 1200, 1800, 4000, 4500, 5000, 7000, 8000]

    fig2, ax2 = plt.subplots()
    ax2.plot(timeline, line_views, label="Views", color="black")
    ax2.plot(timeline, line_saves, label="Saves", color="blue")
    ax2.set_xlabel("Time")
    ax2.set_ylabel("Views / Saves")
    ax2.legend()
    st.pyplot(fig2)

# --- Top Recipes Section ---
with col3:
    st.subheader("Top Recipes")

    def recipe_card(rank, name, image_url):
        st.markdown(f"**{rank}. {name}**")
        st.image(image_url, width=120)
        st.button("View details", key=name)

    recipe_card("★ 1", "Acai Smoothie Bowl", "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/A%C3%A7a%C3%AD_na_Tigela.jpg/640px-A%C3%A7a%C3%AD_na_Tigela.jpg")
    recipe_card("2", "Tiramisu Cake", "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Tiramisu_-_Raffaele_Diomede.jpg/640px-Tiramisu_-_Raffaele_Diomede.jpg")
    recipe_card("3", "Steak & Eggs", "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Steak_and_eggs_0001.jpg/640px-Steak_and_eggs_0001.jpg")

# --- Export Button ---
st.markdown("---")
st.download_button("📄 Export as PDF/PNG", data="Report data placeholder", file_name="analytics_export.pdf")

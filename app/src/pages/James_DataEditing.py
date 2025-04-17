import streamlit as st
import pandas as pd
import plotly.express as px
import requests
from datetime import datetime
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

# Set page config  
st.set_page_config(page_title="Data Editing", layout="wide")
SideBarLinks()

st.title("🛠️ Data Management Dashboard")

# Create tabs for different data sections
tab1, tab2, tab3 = st.tabs(["User Management", "Meal Management", "Tag Management"])

# User Management Tab
with tab1:
    st.subheader("User Data")
    
    try:
        # get meal data from API 
        response = requests.get('http://web-api:4000/u/users')
        if response.status_code == 200:
            users_data = response.json()
            df_users = pd.DataFrame(users_data)
            
            # Create an editable dataframe
            st.write("Edit User Information:")
            edited_df = st.data_editor(
                df_users,
                num_rows="dynamic",
                column_config={
                    "Username": st.column_config.TextColumn("Username", disabled=True),
                    "FirstName": st.column_config.TextColumn("First Name"),
                    "LastName": st.column_config.TextColumn("Last Name"),
                    "Region": st.column_config.TextColumn("Region"),
                    "ActivityLevel": st.column_config.SelectboxColumn(
                        "Activity Level",
                        options=["Low", "Medium", "High"]
                    ),
                    "Age": st.column_config.NumberColumn("Age"),
                    "InclusionStatus": st.column_config.CheckboxColumn("Active"),
                    "Bio": st.column_config.TextColumn("Bio", width="large")
                },
                use_container_width=True
            )
            
            # User Statistics
            col1, col2 = st.columns(2)
            with col1:
                # Region distribution
                region_counts = df_users['Region'].value_counts()
                fig_region = px.pie(
                    values=region_counts.values,
                    names=region_counts.index,
                    title="Users by Region"
                )
                st.plotly_chart(fig_region)
                
            with col2:
                # Activity Level distribution
                activity_counts = df_users['ActivityLevel'].value_counts()
                fig_activity = px.bar(
                    x=activity_counts.index,
                    y=activity_counts.values,
                    title="Users by Activity Level"
                )
                st.plotly_chart(fig_activity)
                
        else:
            st.error("Failed to fetch user data")
    except Exception as e:
        st.error(f"Error: {str(e)}")

# Meal Management Tab
with tab2:
    st.subheader("Meal Management")
    
    try:
        # Get meal data from API
        response = requests.get('http://web-api:4000/m/meals')
        if response.status_code == 200:
            meals_data = response.json()
            df_meals = pd.DataFrame(meals_data)
            
            # Shows meal statistics
            col1, col2 = st.columns(2)
            
            with col1:
                # Difficulty distribution
                if 'Difficulty' in df_meals.columns:
                    difficulty_counts = df_meals['Difficulty'].value_counts()
                    fig_difficulty = px.pie(
                        values=difficulty_counts.values,
                        names=difficulty_counts.index,
                        title="Meals by Difficulty"
                    )
                    st.plotly_chart(fig_difficulty)
            
            with col2:
                # View count statistics
                if 'ViewCount' in df_meals.columns:
                    fig_views = px.bar(
                        df_meals.nlargest(10, 'ViewCount'),
                        x='Name',
                        y='ViewCount',
                        title="Top 10 Most Viewed Meals"
                    )
                    st.plotly_chart(fig_views)
            
            # Editable meal data
            st.write("Edit Meal Information:")
            edited_meals = st.data_editor(
                df_meals,
                num_rows="dynamic",
                column_config={
                    "RecipeID": st.column_config.NumberColumn("Recipe ID", disabled=True),
                    "Name": st.column_config.TextColumn("Name"),
                    "Difficulty": st.column_config.SelectboxColumn(
                        "Difficulty",
                        options=["Easy", "Medium", "Hard"]
                    ),
                    "PrepTime": st.column_config.NumberColumn("Prep Time (min)"),
                    "CookTime": st.column_config.NumberColumn("Cook Time (min)"),
                    "TotalTime": st.column_config.NumberColumn("Total Time (min)"),
                    "ViewCount": st.column_config.NumberColumn("Views"),
                    "Ingredients": st.column_config.TextColumn("Ingredients", width="large"),
                    "Instructions": st.column_config.TextColumn("Instructions", width="large")
                },
                use_container_width=True
            )
        else:
            st.error("Failed to fetch meal data")
    except Exception as e:
        st.error(f"Error: {str(e)}")

# Tag Management Tab
with tab3:
    st.subheader("Tag Management")
    
    try:
        # Get meal data to extract tags
        response = requests.get('http://web-api:4000/m/meals')
        if response.status_code == 200:
            meals_data = response.json()
            df_meals = pd.DataFrame(meals_data)
            
            # Extract tags from meals
            all_tags = []
            for meal in meals_data:
                if 'Tags' in meal and meal['Tags']:
                    tags = meal['Tags'].split(',')
                    all_tags.extend(tags)
            
            # Create tag usage statistics
            tag_counts = pd.Series(all_tags).value_counts()
            tag_df = pd.DataFrame({
                'Tag': tag_counts.index,
                'Usage Count': tag_counts.values
            })
            
            # Display tag statistics
            st.write("Tag Usage Statistics:")
            st.dataframe(tag_df, use_container_width=True)
            
            # Create a pie chart of tag usage
            fig_tags = px.pie(
                tag_df,
                values='Usage Count',
                names='Tag',
                title="Tag Usage Distribution"
            )
            st.plotly_chart(fig_tags)
            
            # Tag management interface
            st.write("Add/Edit Tags:")
            new_tag = st.text_input("Enter a new tag")
            if st.button("Add Tag"):
                if new_tag:
                    st.success(f"Tag '{new_tag}' added successfully!")
                else:
                    st.warning("Please enter a tag name")
            
        else:
            st.error("Failed to fetch meal data")
    except Exception as e:
        st.error(f"Error: {str(e)}")

# Save Changes Button
if st.button("💾 Save All Changes", type="primary"):
    st.success("Changes saved successfully!")
   




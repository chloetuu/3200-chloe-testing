import streamlit as st
import pandas as pd
import mysql.connector
from mysql.connector import Error

st.set_page_config(page_title="Data Editing", layout="wide")

# Database connection configuration
db_config = {
    'host': 'web-api',
    'user': 'root',
    'password': 'root',
    'database': 'Tummy'
}

def get_db_connection():
    try:
        connection = mysql.connector.connect(**db_config)
        return connection
    except Error as e:
        st.error(f"Error connecting to MySQL database: {e}")
        return None

@st.cache_data
def load_meal_data():
    connection = get_db_connection()
    if connection:
        try:
            query = """
                SELECT 
                    m.RecipeID,
                    m.Name,
                    m.Difficulty,
                    m.PrepTime,
                    m.CookTime,
                    m.TotalTime,
                    m.ViewCount,
                    m.DateCreated,
                    GROUP_CONCAT(t.TagName) as Tags,
                    COUNT(DISTINCT sm.Username) as SaveCount,
                    COUNT(DISTINCT i.InteractionID) as InteractionCount
                FROM Meal m
                LEFT JOIN Meal_Tag mt ON m.RecipeID = mt.RecipeID
                LEFT JOIN Tag t ON mt.TagID = t.TagID
                LEFT JOIN Saved_Meals sm ON m.RecipeID = sm.RecipeID
                LEFT JOIN Interaction i ON m.RecipeID = i.RecipeID
                GROUP BY 
                    m.RecipeID, 
                    m.Name, 
                    m.Difficulty, 
                    m.PrepTime,
                    m.CookTime,
                    m.TotalTime,
                    m.ViewCount,
                    m.DateCreated
            """
            df = pd.read_sql(query, connection)
            # Convert Tags from string to list
            df['Tags'] = df['Tags'].fillna('').apply(lambda x: x.split(',') if x else [])
            # Convert DateCreated to datetime
            df['DateCreated'] = pd.to_datetime(df['DateCreated'])
            return df
        except Error as e:
            st.error(f"Error loading meal data: {e}")
            return pd.DataFrame()
        finally:
            connection.close()
    return pd.DataFrame()

st.title("🛠️ Data Editing & Management")

# Back nav in sidebar
st.sidebar.page_link("pages/James_Homepage.py", label="⬅️ Back to James Homepage")

# Load and display meal data
df = load_meal_data()

if not df.empty:
    # --- Editable Table ---
    st.subheader("Edit Recipe Data")
    edited_df = st.data_editor(
        df,
        num_rows="dynamic",
        use_container_width=True,
        disabled=["RecipeID", "DateCreated", "SaveCount", "InteractionCount"],
        column_config={
            "Tags": st.column_config.ListColumn("Tags"),
            "ViewCount": st.column_config.NumberColumn("View Count", format="%d"),
            "PrepTime": st.column_config.NumberColumn("Prep Time (min)", format="%d"),
            "CookTime": st.column_config.NumberColumn("Cook Time (min)", format="%d"),
            "TotalTime": st.column_config.NumberColumn("Total Time (min)", format="%d"),
            "SaveCount": st.column_config.NumberColumn("Save Count", format="%d"),
            "InteractionCount": st.column_config.NumberColumn("Interaction Count", format="%d"),
            "DateCreated": st.column_config.DateColumn("Date Created", format="YYYY-MM-DD")
        }
    )

    # --- Filter Sidebar ---
    with st.sidebar:
        st.header("Filter")
        difficulty_filter = st.multiselect("Difficulty", df["Difficulty"].unique(), default=df["Difficulty"].unique())
        tag_filter = st.multiselect("Tags", sorted(set(tag for tags in df['Tags'] for tag in tags)))
        
        # Time range filter
        st.subheader("Time Range")
        min_time = st.number_input("Min Total Time (min)", min_value=0, value=0)
        max_time = st.number_input("Max Total Time (min)", min_value=0, value=df['TotalTime'].max())
        
        # View count filter
        st.subheader("View Count Range")
        min_views = st.number_input("Min Views", min_value=0, value=0)
        max_views = st.number_input("Max Views", min_value=0, value=df['ViewCount'].max())

    # --- Filtered Table ---
    filtered_df = edited_df[edited_df["Difficulty"].isin(difficulty_filter)]
    if tag_filter:
        filtered_df = filtered_df[filtered_df['Tags'].apply(lambda x: any(tag in x for tag in tag_filter))]
    filtered_df = filtered_df[
        (filtered_df['TotalTime'] >= min_time) & 
        (filtered_df['TotalTime'] <= max_time) &
        (filtered_df['ViewCount'] >= min_views) &
        (filtered_df['ViewCount'] <= max_views)
    ]

    st.subheader("Filtered Table")
    st.dataframe(filtered_df, use_container_width=True)

    # --- Export or Save Changes ---
    st.markdown("---")
    col1, col2 = st.columns(2)

    with col1:
        st.download_button(
            "💾 Download CSV",
            data=filtered_df.to_csv(index=False),
            file_name="meal_data.csv",
            mime="text/csv"
        )

    with col2:
        if st.button("✅ Save Changes"):
            try:
                connection = get_db_connection()
                if connection:
                    cursor = connection.cursor()
                    for _, row in edited_df.iterrows():
                        update_query = """
                            UPDATE Meal 
                            SET Name = %s, 
                                Difficulty = %s, 
                                ViewCount = %s,
                                PrepTime = %s,
                                CookTime = %s,
                                TotalTime = %s
                            WHERE RecipeID = %s
                        """
                        cursor.execute(update_query, (
                            row['Name'],
                            row['Difficulty'],
                            row['ViewCount'],
                            row['PrepTime'],
                            row['CookTime'],
                            row['TotalTime'],
                            row['RecipeID']
                        ))
                    connection.commit()
                    st.success("Changes saved successfully!")
            except Error as e:
                st.error(f"Error saving changes: {e}")
            finally:
                if connection:
                    connection.close()
else:
    st.error("No data available. Please check your database connection.")




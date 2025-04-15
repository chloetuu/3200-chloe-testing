import streamlit as st
import pandas as pd

st.set_page_config(page_title="Data Editing", layout="wide")

st.title("🛠️ Data Editing & Management")



# --- Simulated Dataset ---
@st.cache_data
def load_data():
    return pd.DataFrame({
        "Recipe ID": [1, 2, 3],
        "Title": ["Acai Smoothie Bowl", "Tiramisu Cake", "Steak & Eggs"],
        "Category": ["Healthy", "Dessert", "Breakfast"],
        "Views": [120000, 95000, 80000],
        "Saves": [85000, 70000, 60000],
        "Flagged": [False, False, True]
    })

df = load_data()

# --- Editable Table ---
st.subheader("Edit Recipe Data")
edited_df = st.data_editor(
    df,
    num_rows="dynamic",
    use_container_width=True,
    disabled=["Recipe ID"],
    column_config={
        "Flagged": st.column_config.CheckboxColumn("Flagged for Review")
    }
)

# --- Filter Sidebar ---
with st.sidebar:
    st.header("Filter")
    category_filter = st.multiselect("Category", df["Category"].unique(), default=df["Category"].unique())
    show_flagged = st.checkbox("Only Show Flagged", value=False)

# --- Filtered Table ---
filtered_df = edited_df[edited_df["Category"].isin(category_filter)]

if show_flagged:
    filtered_df = filtered_df[filtered_df["Flagged"] == True]

st.subheader("Filtered Table")
st.dataframe(filtered_df, use_container_width=True)

# --- Export or Save Changes ---
st.markdown("---")
col1, col2 = st.columns(2)

with col1:
    st.download_button("💾 Download CSV", data=filtered_df.to_csv(index=False), file_name="cleaned_data.csv", mime="text/csv")

with col2:
    if st.button("✅ Save Changes"):
        st.success("Changes saved (mocked — hook to backend later)")




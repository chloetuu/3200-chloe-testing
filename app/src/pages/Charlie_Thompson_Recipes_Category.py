import streamlit as st
from modules.nav import SideBarLinks
from modules.recipe import get_recipes_by_category, get_all_categories

# Set page configuration
st.set_page_config(
    page_title="Charlie's Category-Based Recipes",
    page_icon="🥗",
    layout="wide"
)

# Display sidebar links
SideBarLinks()

# Page title
st.title("Explore Meals by Category")
st.write("Browse recipes organized by their categories")

# Get all available categories
categories = get_all_categories()

# Create a dropdown to select category
selected_category = st.selectbox(
    "Select a Category",
    categories,
    index=0,
    help="Choose a category to view related recipes"
)

# Display recipes for the selected category
if selected_category:
    recipes = get_recipes_by_category(selected_category)
    
    if recipes:
        st.subheader(f"Recipes in {selected_category}")
        
        # Display recipes in a grid
        cols = st.columns(3)
        for i, recipe in enumerate(recipes):
            with cols[i % 3]:
                st.image(recipe['image_url'], use_column_width=True)
                st.subheader(recipe['name'])
                st.write(f"Prep Time: {recipe['prep_time']} minutes")
                st.write(f"Cook Time: {recipe['cook_time']} minutes")
                st.write(f"Servings: {recipe['servings']}")
                if st.button("View Recipe", key=f"view_{recipe['id']}"):
                    st.session_state['selected_recipe'] = recipe
                    st.switch_page("pages/Charlie_Thompson_Recipe_Details.py")
    else:
        st.info(f"No recipes found in the {selected_category} category.") 
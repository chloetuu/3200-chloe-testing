from flask import Flask

from backend.db_connection import db
from backend.customers.customer_routes import customers
from backend.products.products_routes import products
# from backend.simple.simple_routes import simple_routes
from backend.meals.meal_routes import meals
from backend.favorites.favorites_routes import favorites 
from backend.categories.category_routes import categories
from backend.error.error_routes import issues
from backend.users.users_routes import users
import os
from dotenv import load_dotenv

# new changes
from backend.blogs.blog_routes import blogs
def create_app():
    app = Flask(__name__)

    # Load environment variables
    # This function reads all the values from inside
    # the .env file (in the parent folder) so they
    # are available in this file.  See the MySQL setup 
    # commands below to see how they're being used.
    load_dotenv()

    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    # app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'
    app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')

    # # these are for the DB object to be able to connect to MySQL. 
    # app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_USER'] = os.getenv('DB_USER').strip()
    app.config['MYSQL_DATABASE_PASSWORD'] = os.getenv('MYSQL_ROOT_PASSWORD').strip()
    app.config['MYSQL_DATABASE_HOST'] = os.getenv('DB_HOST').strip()
    app.config['MYSQL_DATABASE_PORT'] = int(os.getenv('DB_PORT').strip())
    app.config['MYSQL_DATABASE_DB'] = os.getenv('DB_NAME').strip()  # Change this to your DB name

    # Initialize the database object with the settings above. 
    app.logger.info('current_app(): starting the database connection')
    db.init_app(app)

    # Add the default route 
    # Can be accessed from a web browser 
    # http://ip.address:port/
    # Example: localhost: 8001

    @app.route("/")
    def welcome(): 
        return "<h1> Welcome to the Summer 2025 CS 3200 Project Template Repo<h1>"
    
    
    # Example route for testing streamlit
    @app.route("/data")
    def getData():
        data = { 
            "staff": [
                {
                    "Name": "Mark Fontenot",
                    "role": "Instructor"
                }, 
                {
                    "Name": "Ashley Davis",
                    "role": "TA"
                }
            ]
        }
        return data
    


    # Register the routes from each Blueprint with the app object
    # and give a url prefix to each
    app.logger.info('current_app(): registering blueprints with Flask app object.')   
    # app.register_blueprint(simple_routes)
    app.register_blueprint(categories,   url_prefix='/c')
    app.register_blueprint(products,    url_prefix='/p')
    app.register_blueprint(meals,       url_prefix='/m')
    app.register_blueprint(blogs,       url_prefix='/b')
    app.register_blueprint(favorites,   url_prefix='/f')
    app.register_blueprint(issues,      url_prefix='/l')
    app.register_blueprint(users,      url_prefix='/u')
    
    

    # Don't forget to return the app object
    return app


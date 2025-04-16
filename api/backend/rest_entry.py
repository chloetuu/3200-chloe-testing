from flask import Flask
from backend.db_connection import db
from backend.customers.customer_routes import customers
from backend.products.products_routes import products
#from backend.simple.simple_routes import simple_routes  # Uncomment if needed
from backend.meals.meal_routes import meals
from backend.error.error_routes import issues

import os
from dotenv import load_dotenv

def create_app():
    app = Flask(__name__)

    # Load environment variables from .env (which should be in your project root)
    load_dotenv()

    # Set secret key for secure sessions and other security needs
    app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')

    # Database connection settings for MySQL
    app.config['MYSQL_DATABASE_USER'] = os.getenv('DB_USER').strip()
    app.config['MYSQL_DATABASE_PASSWORD'] = os.getenv('MYSQL_ROOT_PASSWORD').strip()
    app.config['MYSQL_DATABASE_HOST'] = os.getenv('DB_HOST').strip()
    app.config['MYSQL_DATABASE_PORT'] = int(os.getenv('DB_PORT').strip())
    app.config['MYSQL_DATABASE_DB'] = os.getenv('DB_NAME').strip()

    # Initialize the database object with the settings above
    app.logger.info('Starting the database connection')
    db.init_app(app)

    # Define the default route
    @app.route("/")
    def welcome():
        return "<h1>Welcome to the Summer 2025 CS 3200 Project Template Repo</h1>"

    # A sample route for testing data transmission
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

    # Register blueprints with appropriate URL prefixes
    app.logger.info('Registering blueprints with the Flask app object')
    app.register_blueprint(customers,   url_prefix='/c')
    app.register_blueprint(products,    url_prefix='/p')
    app.register_blueprint(meals,       url_prefix='/m')
    app.register_blueprint(issues,      url_prefix='/e')
    # If you decide to use the simple_routes, uncomment the following line:
    # app.register_blueprint(simple_routes, url_prefix='/s')

    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True)

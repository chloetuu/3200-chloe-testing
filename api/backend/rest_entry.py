from flask import Flask
from backend.db_connection import db
from backend.error.error_route import issues

# Add your other route imports as needed
# from backend.customers.customer_routes import customers
# from backend.products.products_routes import products
# from backend.meals.meal_routes import meals

import os
from dotenv import load_dotenv

def create_app():
    app = Flask(__name__)
    load_dotenv()

    app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')
    app.config['MYSQL_DATABASE_USER'] = os.getenv('DB_USER').strip()
    app.config['MYSQL_DATABASE_PASSWORD'] = os.getenv('MYSQL_ROOT_PASSWORD').strip()
    app.config['MYSQL_DATABASE_HOST'] = os.getenv('DB_HOST').strip()
    app.config['MYSQL_DATABASE_PORT'] = int(os.getenv('DB_PORT').strip())
    app.config['MYSQL_DATABASE_DB'] = os.getenv('DB_NAME').strip()

    app.logger.info('Starting DB connection...')
    db.init_app(app)

    @app.route('/')
    def welcome():
        return "<h1>Welcome to the Summer 2025 CS 3200 Project Template Repo</h1>"

    @app.route('/data')
    def get_data():
        return {
            "staff": [
                {"Name": "Mark Fontenot", "role": "Instructor"},
                {"Name": "Ashley Davis", "role": "TA"}
            ]
        }

    # Register your blueprints here
    app.logger.info('Registering blueprints...')
    app.register_blueprint(issues, url_prefix='/e')
    # app.register_blueprint(customers, url_prefix='/c')
    # app.register_blueprint(products, url_prefix='/p')
    # app.register_blueprint(meals, url_prefix='/m')

    return app

# Only needed if you want to run this directly
if __name__ == '__main__':
    app = create_app()
    app.run(debug=True)

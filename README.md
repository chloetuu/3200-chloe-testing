# Tummy - Recipe Management System

A comprehensive recipe management system that allows users to discover, save, and share recipes while tracking their nutritional information and meal planning.

## Team Members
- Jaden Chin
- Melanie Yu
- Chloe Tu
- Thanawan Napawan

## Project Overview
Tummy is a web application that provides users with a platform to:
- Browse and search recipes
- Save favorite recipes
- Track nutritional information
- Plan meals
- Share recipes with others
- Monitor user engagement and analytics

## Prerequisites
- A GitHub Account
- A terminal-based git client or GUI Git client such as GitHub Desktop or the Git plugin for VSCode
- VSCode with the Python Plugin
- A distribution of Python running on your laptop (Anaconda or Miniconda recommended)
- Docker and Docker Compose installed

## Project Components
The project consists of three main components running in separate Docker containers:

1. **Streamlit App** (`./app` directory)
   - User interface for recipe management
   - Role-based access control
   - Analytics dashboard

2. **Flask REST API** (`./api` directory)
   - Handles all backend operations
   - Manages database interactions
   - Provides endpoints for user management, recipes, and analytics

3. **MySQL Database** (initialized from `./database-files`)
   - Stores user data
   - Recipe information
   - Interaction logs
   - Analytics data

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone [your-repository-url]
   cd [repository-name]
   ```

2. **Environment Setup**
   - Copy `.env.template` to `.env` in the `api` directory
   - Update the following environment variables in `.env`:
     ```
     MYSQL_HOST=db
     MYSQL_USER=root
     MYSQL_PASSWORD=your_password_here
     MYSQL_DATABASE=tummy
     ```

3. **Build and Start Containers**
   For development/testing:
   ```bash
   docker compose -f docker-compose-testing.yaml up -d
   ```
   
   For production:
   ```bash
   docker compose up -d
   ```

4. **Access the Application**
   - Streamlit App: http://localhost:8501
   - API Documentation: http://localhost:4000

## Container Management

### Starting Containers
```bash
# Start all containers
docker compose up -d

# Start specific containers
docker compose up db -d    # Database only
docker compose up api -d   # API only
docker compose up app -d   # App only
```

### Stopping Containers
```bash
# Stop all containers
docker compose down

# Stop containers without removing them
docker compose stop
```

## Role-Based Access Control
The application implements three main roles:
1. **Regular Users**
   - Browse and search recipes
   - Save favorite recipes
   - Track nutritional information

2. **Content Creators**
   - Create and edit recipes
   - Manage recipe categories
   - View basic analytics

3. **Administrators**
   - Manage users
   - Access advanced analytics
   - System configuration

## API Documentation
The API provides endpoints for:
- User management (`/u/*`)
- Recipe operations (`/m/*`)
- Favorites management (`/f/*`)
- Error logging (`/l/*`)
- Alert system (`/a/*`)
- Tag management (`/t/*`)

## Troubleshooting
If you encounter issues:
1. Check container logs: `docker compose logs [service-name]`
2. Verify environment variables in `.env`
3. Ensure all required ports are available
4. Check database connection status

## Contributing
Please follow the standard git workflow:
1. Create a feature branch
2. Make your changes
3. Submit a pull request
4. Get code review approval
5. Merge to main branch

## Youtube Demo
https://www.youtube.com/watch?v=g04XQGjXTnA


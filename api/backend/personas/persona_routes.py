from flask import Blueprint, render_template, request, session, redirect, url_for

bp = Blueprint('personas', __name__, template_folder='templates')

user_roles = {
    'nina': 'user',
    'jade': 'devops',
    'james': 'analyst',
    'charlie': 'influencer'
}

@bp.route('/')
def home():
    return render_template('login.html')

@bp.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    role = user_roles.get(username)

    if role:
        session['username'] = username
        session['role'] = role
        return redirect(url_for('personas.dashboard'))
    return "Invalid login", 401

@bp.route('/dashboard')
def dashboard():
    role = session.get('role')
    if role == 'user':
        return redirect(url_for('personas.nina_dashboard'))
    elif role == 'devops':
        return redirect(url_for('personas.jade_dashboard'))
    elif role == 'analyst':
        return redirect(url_for('personas.james_dashboard'))
    elif role == 'influencer':
        return redirect(url_for('personas.charlie_dashboard'))
    return "Unauthorized", 403

@bp.route('/nina')
def nina_dashboard():
    return render_template('nina_dashboard.html')

@bp.route('/jade')
def jade_dashboard():
    return render_template('jade_dashboard.html')

@bp.route('/james')
def james_dashboard():
    return render_template('james_dashboard.html')

@bp.route('/charlie')
def charlie_dashboard():
    return render_template('charlie_dashboard.html')

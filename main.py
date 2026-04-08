from flask import Flask, render_template, flash, redirect, url_for, session, request
import mysql.connector
import pickle
import pandas as pd
import os
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import seaborn as sns
from flask import request, render_template
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split

def db_connect():
    return mysql.connector.connect(
        host = 'localhost',
        user = 'root',
        password = '',
        database = 'trip_estimator'
    )

cost_model = pickle.load(open("models/travel_cost_model.pkl","rb"))
similarity_matrix = pickle.load(open("models/recommendation_similarity.pkl","rb"))
tourist_data = pickle.load(open("models/tourist_data.pkl","rb"))
model_features = pickle.load(open("models/model_features.pkl","rb"))

def recommend_spots(index, top_n=5):
    scores = list(enumerate(similarity_matrix[index]))
    scores = sorted(scores, key=lambda x: x[1], reverse=True)
    scores = scores[1:top_n+1]
    spot_indices = [i[0] for i in scores]
    return tourist_data.iloc[spot_indices][['spot_name','state','category']]


app = Flask(__name__)
app.secret_key='travelmanio'

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    distance = int(request.form['distance'])
    travel_mode = request.form['travel_mode']
    hotel_type = request.form['hotel_type']
    days = int(request.form['days'])
    season_index = float(request.form['season_index'])
    entry_fee = int(request.form['entry_fee'])
    food_cost = int(request.form['food_cost'])
    local_transport = int(request.form['local_transport'])
    # Create input dataframe
    input_data = pd.DataFrame([{
        'distance_km': distance,
        'travel_mode': travel_mode,
        'hotel_type': hotel_type,
        'days': days,
        'season_index': season_index,
        'entry_fee': entry_fee,
        'food_cost_per_day': food_cost,
        'local_transport_per_day': local_transport
    }])
    # convert categorical
    input_data = pd.get_dummies(input_data)
    # match training columns
    input_data = input_data.reindex(columns=model_features, fill_value=0)
    # predict cost
    predicted_cost = cost_model.predict(input_data)[0]
    # get recommendation example
    recommendations = recommend_spots(10)
    return render_template(
        "result.html",
        cost=round(predicted_cost,2),
        spots=recommendations.to_dict(orient='records')
    )

@app.route('/admin_login', methods=['GET','POST'])
def admin_login():

    if request.method == "POST":

        username = request.form['username']
        password = request.form['password']

        conn = db_connect()
        cursor = conn.cursor(dictionary=True)

        query = "SELECT * FROM admin WHERE username=%s AND password=%s"
        cursor.execute(query,(username,password))
        admin = cursor.fetchone()
        cursor.close()
        conn.close()
        if admin:
            return redirect('/admin_dashboard')
        else:
            return render_template('admin_login.html',msg="Invalid Username or Password")

    return render_template('admin_login.html')

@app.route('/admin_dashboard')
def admin_dashboard():

    conn = db_connect()
    cursor = conn.cursor(dictionary=True)

    '''
    cursor.execute("SELECT COUNT(*) as total_users FROM users")
    total_users = cursor.fetchone()['total_users']

    cursor.execute("SELECT COUNT(*) as total_destinations FROM destinations")
    total_destinations = cursor.fetchone()['total_destinations']

    cursor.execute("SELECT COUNT(*) as total_trips FROM trips")
    total_trips = cursor.fetchone()['total_trips']

    cursor.execute("SELECT COUNT(*) as total_predictions FROM predictions")
    total_predictions = cursor.fetchone()['total_predictions']

    cursor.execute("SELECT * FROM users ORDER BY id DESC LIMIT 5")
    users = cursor.fetchall()

    return render_template(
        'admin_dashboard.html',
        total_users=total_users,
        total_destinations=total_destinations,
        total_trips=total_trips,
        total_predictions=total_predictions,
        users=users
    )
    '''
    return render_template('admin_dashboard.html')

@app.route('/upload_dataset', methods=['POST'])
def upload_dataset():
    file = request.files['dataset']
    filepath = os.path.join("dataset", file.filename)
    file.save(filepath)
    # STEP 1 : Dataset Upload
    data = pd.read_excel(filepath)
    dataset_preview = data.head(10).to_html(classes="table table-bordered")
    rows = data.shape[0]
    columns = data.shape[1]
    # STEP 2 : Preprocessing
    data = data.fillna(0)
    data = data.drop_duplicates()
    preprocessing_info = f"Rows: {rows}, Columns: {columns}"
    # STEP 3 : Feature Extraction
    X = data[['distance_km','travel_mode','hotel_type','days',
              'season_index','entry_fee','food_cost_per_day',
              'local_transport_per_day']]

    y = data['total_cost']
    X = pd.get_dummies(X)
    feature_columns = list(X.columns)
    # STEP 4 : Model Training
    X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.2)
    model = RandomForestRegressor(n_estimators=200)
    model.fit(X_train,y_train)
    accuracy = model.score(X_test,y_test)

    os.makedirs("static/graphs", exist_ok=True)
    # Feature Importance
    importance = model.feature_importances_
    plt.figure(figsize=(8,5))
    plt.barh(X.columns, importance)
    plt.title("Feature Importance")
    plt.savefig("static/graphs/feature_importance.png")
    plt.close()
    # Correlation Heatmap
    numeric_data = data.select_dtypes(include=['int64','float64'])
    plt.figure(figsize=(8,6))
    sns.heatmap(numeric_data.corr(), cmap="coolwarm")
    plt.title("Correlation Matrix")
    plt.savefig("static/graphs/correlation.png")
    plt.close()
    # Cost Distribution
    plt.figure(figsize=(8,5))
    plt.hist(data['total_cost'], bins=30)
    plt.title("Trip Cost Distribution")
    plt.savefig("static/graphs/cost_distribution.png")
    plt.close()
    return render_template(
        "admin_dashboard.html",
        processed=True,
        dataset_preview=dataset_preview,
        rows=rows,
        columns=columns,
        preprocessing_info=preprocessing_info,
        feature_columns=feature_columns,
        accuracy=round(accuracy,3)
    )

@app.route('/register', methods=['GET','POST'])
def register():
    if request.method == "POST":
        name = request.form['name']
        email = request.form['email']
        city = request.form['city']
        phone = request.form['phone']
        username = request.form['username']
        password = request.form['password']
        conn = db_connect()
        cursor = conn.cursor()
        cursor.execute("select username from users where username=%s",(username,))
        exist = cursor.fetchone()
        if exist:
            display_msg = "Not Created! Username Already used Try different.."
            return render_template('register.html',display_msg=display_msg)
        query = "INSERT INTO users(name,email,city,password,username,phone) VALUES(%s,%s,%s,%s,%s,%s)"
        cursor.execute(query,(name,email,city,password,username,phone))
        conn.commit()
        cursor.close()
        conn.close()
        display_msg = 'Registertaion Successfull, Redirect To login Page...'
        return render_template('register.html',msg="ok",display_msg=display_msg)
    return render_template("register.html")

@app.route('/user_login',methods=['GET','POST'])
def user_login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        conn = db_connect()
        cursor = conn.cursor(dictionary=True)
        query = "select * from users where username=%s AND password=%s"
        cursor.execute(query,(username,password))
        user = cursor.fetchone()
        if user:
            session['user_id'] = user['id']
            session['username'] = user['username']
            return redirect(url_for('user_home'))
        else:
            msg='Invalid Username or Password'
            return render_template('user_login.html',msg=msg)
    return render_template('user_login.html')

@app.route('/user_home')
def user_home():
    if 'username' not in session:
        return redirect(url_for('user_login'))
    conn = db_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE username=%s", (session['username'],))
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    predicted_cost = session.pop('predicted_cost', None)
    recommendations = session.pop('recommendations', None)
    trip_plan = session.pop('trip_plan', None) 

    return render_template(
        "user_home.html",
        user=user,
        predicted_cost=predicted_cost,
        recommendations=recommendations,
        trip_plan=trip_plan 
    )

@app.route('/user_reports')
def user_reports():

    if 'user_id' not in session:
        return redirect('/user_login')

    user_id = session['user_id']
    conn = db_connect()
    cursor = conn.cursor(dictionary=True)

    # ===== COST REPORT =====
    cursor.execute("""
        SELECT * FROM cost_predictions
        WHERE user_id=%s
        AND DATE(created_at) >= CURDATE() - INTERVAL 1 DAY
        ORDER BY id DESC
    """, (user_id,))
    cost_reports = cursor.fetchall()

    # ===== DESTINATION REPORT =====
    cursor.execute("""
        SELECT * FROM destination_reports
        WHERE user_id=%s
        AND DATE(created_at) >= CURDATE() - INTERVAL 1 DAY
        ORDER BY id DESC
    """, (user_id,))
    destination_reports = cursor.fetchall()

    # ===== TRIP PLAN REPORT =====
    cursor.execute("""
        SELECT * FROM trip_plans
        WHERE user_id=%s
        AND DATE(created_at) >= CURDATE() - INTERVAL 1 DAY
        ORDER BY id DESC
    """, (user_id,))
    trip_reports = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template(
        "user_reports.html",
        cost_reports=cost_reports,
        destination_reports=destination_reports,
        trip_reports=trip_reports
    )

@app.route('/predict_cost', methods=['POST'])
def predict_cost():

    if 'user_id' not in session:
        return redirect('/user_login')

    conn = db_connect()
    cursor = conn.cursor()

    distance = float(request.form['distance'])
    days = int(request.form['days'])
    entry_fee = float(request.form['entry_fee'])
    season_index = float(request.form['season_index'])
    travel_mode = request.form['travel_mode']
    hotel_type = request.form['hotel_type']
    food_cost = float(request.form['food_cost_per_day'])
    transport_cost = float(request.form['local_transport_per_day'])

    input_data = pd.DataFrame([{
        'distance_km': distance,
        'travel_mode': travel_mode,
        'hotel_type': hotel_type,
        'days': days,
        'season_index': season_index,
        'entry_fee': entry_fee,
        'food_cost_per_day': food_cost,
        'local_transport_per_day': transport_cost
    }])

    input_data = pd.get_dummies(input_data)
    input_data = input_data.reindex(columns=model_features, fill_value=0)

    prediction = cost_model.predict(input_data)[0]
    predicted_cost = float(round(prediction, 2))

    cursor.execute("""
        INSERT INTO cost_predictions
        (user_id,distance_km,days,travel_mode,hotel_type,entry_fee,season_index,predicted_cost)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s)
    """,(
        session['user_id'],
        distance,
        days,
        travel_mode,
        hotel_type,
        entry_fee,
        season_index,
        predicted_cost
    ))

    conn.commit()
    cursor.close()
    conn.close()
    session['predicted_cost'] = predicted_cost
    return redirect(url_for('user_home'))

@app.route('/recommend_destination', methods=['POST'])
def recommend_destination():

    if 'user_id' not in session:
        return redirect('/user_login')

    conn = db_connect()
    cursor = conn.cursor()

    category = request.form['category']
    budget = request.form['budget_type']
    season = request.form['season']

    df = tourist_data.copy()

    df['category'] = df['category'].str.lower()
    df['budget_type'] = df['budget_type'].str.lower()
    df['season'] = df['season'].str.lower()

    category = category.lower()
    budget = budget.lower()
    season = season.lower()

    filtered = df[
        (df['category'] == category) &
        (df['budget_type'] == budget) &
        (df['season'] == season)
    ]

    if filtered.empty:
        filtered = df[df['category'] == category]

    if filtered.empty:
        filtered = df

    recommendations = filtered.sample(6)

    for place in recommendations.to_dict('records'):

        cursor.execute("""
            INSERT INTO destination_reports
            (user_id, category, budget_type, season, spot_name, state)
            VALUES (%s,%s,%s,%s,%s,%s)
        """, (
            int(session['user_id']),
            category,
            budget,
            season,
            place['spot_name'],
            place['state']
        ))

    conn.commit()
    cursor.close()
    conn.close()
    # store recommendations in session
    session['recommendations'] = recommendations.to_dict('records')
    return redirect(url_for('user_home'))

# ================= DISTANCE FUNCTION =================
def get_distance(from_place, to_place):
    conn = db_connect()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT distance_km FROM distance_map
        WHERE LOWER(from_place)=%s AND LOWER(to_place)=%s
    """, (from_place.lower(), to_place.lower()))

    result = cursor.fetchone()

    if not result:
        cursor.execute("""
            SELECT distance_km FROM distance_map
            WHERE LOWER(from_place)=%s AND LOWER(to_place)=%s
        """, (to_place.lower(), from_place.lower()))
        result = cursor.fetchone()

    cursor.close()
    conn.close()

    return float(result[0]) if result else 500


# ================= PLACE LOGIC =================
def get_budget_places(to_place, budget):

    conn = db_connect()
    cursor = conn.cursor(dictionary=True)
    # 1. Get places with same budget
    cursor.execute("""
        SELECT * FROM tourist_data
        WHERE LOWER(state)=%s AND LOWER(budget_type)=%s
        LIMIT 5
    """, (to_place.lower(), budget.lower()))
    places = cursor.fetchall()
    # 2. If less than 5 → fill with other budget places
    if len(places) < 5:
        cursor.execute("""
            SELECT * FROM tourist_data
            WHERE LOWER(state)=%s
        """, (to_place.lower(),))

        all_places = cursor.fetchall()
        # remove duplicates
        existing_ids = [p['id'] for p in places]

        for p in all_places:
            if p['id'] not in existing_ids:
                places.append(p)

            if len(places) == 5:
                break

    cursor.close()
    conn.close()
    return places


@app.route('/plan_trip', methods=['POST'])
def plan_trip():

    if 'user_id' not in session:
        return redirect('/user_login')

    conn = db_connect()
    cursor = conn.cursor()

    # ===== USER INPUT =====
    from_place = request.form['from_place'].strip().lower()
    to_place = request.form['to_place'].strip().lower()
    from_date = request.form['from_date']
    to_date = request.form['to_date']
    budget = request.form['budget_type'].strip().lower()
    transport_mode = request.form['transport_mode'].strip().lower()
    persons = int(request.form['persons'])

    # ===== DATE CALCULATION =====
    from datetime import datetime
    d1 = datetime.strptime(from_date, "%Y-%m-%d")
    d2 = datetime.strptime(to_date, "%Y-%m-%d")
    days = (d2 - d1).days + 1

    # ===== DISTANCE (USE FUNCTION) =====
    distance = get_distance(from_place, to_place)

    # ===== TRAVEL COST =====
    rate_map = {
        'bus': 1.5,
        'train': 1.2,
        'flight': 5,
        'car': 3,
        'bike': 1
    }

    rate = rate_map.get(transport_mode, 2)
    travel_cost = distance * rate * persons

    # ===== BUDGET COST =====
    if budget == 'low':
        hotel_per_day, food_per_day = 800, 300
    elif budget == 'moderate':
        hotel_per_day, food_per_day = 1500, 600
    else:
        hotel_per_day, food_per_day = 3000, 1200

    stay_cost = hotel_per_day * days
    food_cost = food_per_day * days * persons

    # ===== TEMP TOTAL (before entry) =====
    temp_total = travel_cost + stay_cost + food_cost

    places = get_budget_places(to_place, budget)

    # ===== ENTRY COST =====
    entry_cost = sum([p.get('entry_fee', 100) for p in places])

    # ===== FINAL TOTAL =====
    total_cost = temp_total + entry_cost

    # ===== SAVE TO DB =====
    cursor.execute("""
        INSERT INTO trip_plans
        (user_id, from_place, to_place, days, persons, budget, transport_mode, total_cost)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s)
    """, (
        session['user_id'],
        from_place,
        to_place,
        days,
        persons,
        budget,
        transport_mode,
        total_cost
    ))

    conn.commit()
    cursor.close()
    conn.close()

    session['trip_plan'] = {
        'from': from_place.title(),
        'to': to_place.title(),
        'days': days,
        'persons': persons,
        'budget': budget,
        'transport': transport_mode,
        'distance': distance,
        'travel_cost': round(travel_cost, 2),
        'stay_cost': round(stay_cost, 2),
        'food_cost': round(food_cost, 2),
        'entry_cost': round(entry_cost, 2),
        'total_cost': round(total_cost, 2),
        'places': places
    }
    return redirect(url_for('user_home'))

@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)



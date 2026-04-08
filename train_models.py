# ============================================
# AI Travel Planner Model Training Script
# Trains:
# 1) Tourist Recommendation Model
# 2) Trip Cost Prediction Model
# ============================================

import pandas as pd
import pickle
import os

from sklearn.metrics.pairwise import cosine_similarity
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import r2_score


# ============================================
# STEP 1 — Create models folder
# ============================================

if not os.path.exists("models"):
    os.makedirs("models")

print("Models folder ready.")


# ============================================
# STEP 2 — Load Dataset
# ============================================

print("\nLoading dataset...")

data = pd.read_excel("travel_ai_combined_dataset_5000.xlsx")

print("Dataset loaded successfully")
print(data.head())


# ============================================
# STEP 3 — Tourist Recommendation Training
# ============================================

print("\nTraining Tourist Recommendation Model...")

recommend_features = data[['category','budget_type','season','popularity_score']]

# Convert categorical data
recommend_features_encoded = pd.get_dummies(recommend_features)

# Calculate similarity
similarity_matrix = cosine_similarity(recommend_features_encoded)

# Save recommendation data
pickle.dump(similarity_matrix, open("models/recommendation_similarity.pkl","wb"))
pickle.dump(data, open("models/tourist_data.pkl","wb"))

print("Recommendation model saved in models folder.")


# ============================================
# STEP 4 — Cost Prediction Training
# ============================================

print("\nTraining Cost Prediction Model...")

X = data[['distance_km',
          'travel_mode',
          'hotel_type',
          'days',
          'season_index',
          'entry_fee',
          'food_cost_per_day',
          'local_transport_per_day']]

y = data['total_cost']

# Encode categorical columns
X = pd.get_dummies(X)

# Split dataset
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Train Random Forest
model = RandomForestRegressor(
    n_estimators=200,
    random_state=42
)

model.fit(X_train, y_train)

print("Model training completed.")


# ============================================
# STEP 5 — Evaluate Model
# ============================================

predictions = model.predict(X_test)

accuracy = r2_score(y_test, predictions)

print("Model Accuracy:", accuracy)


# ============================================
# STEP 6 — Save Cost Prediction Model
# ============================================

pickle.dump(model, open("models/travel_cost_model.pkl","wb"))
pickle.dump(X.columns, open("models/model_features.pkl","wb"))

print("Cost prediction model saved in models folder.")


# ============================================
# STEP 7 — Example Recommendation Function
# ============================================

def recommend_spots(index, top_n=5):

    scores = list(enumerate(similarity_matrix[index]))

    scores = sorted(scores, key=lambda x: x[1], reverse=True)

    scores = scores[1:top_n+1]

    spot_indices = [i[0] for i in scores]

    return data.iloc[spot_indices][['spot_name','category','state']]


print("\nExample Recommendation:")
print(recommend_spots(5))


print("\nTraining Completed Successfully.")
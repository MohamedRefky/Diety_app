from flask import Flask, request, jsonify
import pickle
import os
import pandas as pd
from sklearn.preprocessing import LabelEncoder

# Load the trained model
with open('decision_tree_model3.pkl', 'rb') as f:
    loaded_model = pickle.load(f)

# Initialize Flask app
app = Flask(__name__)

# Define the path to save the LabelEncoder state
label_encoder_path = 'label_encoder.pkl'

# Initialize and load the LabelEncoder state
le = LabelEncoder()
if os.path.exists(label_encoder_path):
    try:
        with open(label_encoder_path, 'rb') as f:
            le = pickle.load(f)
        print("LabelEncoder loaded successfully with classes:", le.classes_)
    except Exception as e:
        print(f"Error loading label encoder from file: {e}. Falling back to standard encoding.")
        le.fit(['Female', 'Male'])
else:
    print("LabelEncoder file not found. Fitting on standard ['Female', 'Male'].")
    le.fit(['Female', 'Male'])

# Define a route for prediction
@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get input data from request
        data = request.json

        # Convert input data to DataFrame
        input_data = pd.DataFrame(data)

        # Scale Height to meters if it is provided in centimeters (e.g. > 3.0)
        if 'Height' in input_data.columns:
            input_data['Height'] = input_data['Height'].apply(lambda x: x / 100.0 if x > 3.0 else x)

        # Transform 'Gender' using the pre-loaded LabelEncoder
        input_data['Gender'] = le.transform(input_data['Gender'])

        # Make predictions using the loaded model
        predictions = loaded_model.predict(input_data)

        # Return predictions as JSON response
        return jsonify({'predictions': predictions.tolist()}), 200
    except Exception as e:
        # Return error message if an exception occurs
        return jsonify({'error': str(e)}), 400

# Run the Flask app
if __name__ == '__main__':
    # Change the host to '0.0.0.0' to make the server accessible from other devices on the same network
    app.run(debug=True)

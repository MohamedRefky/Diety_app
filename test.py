import requests # type: ignore

# URL of your Flask app
url = 'http://127.0.0.1:5000/predict'

# Sample data for testing
data = {
    'Weight': [80],
    'Height': [160],
    'Gender': ['Male'],
    'Age': [22]
}

# Send POST request with JSON payload
response = requests.post(url, json=data)

# Check if request was successful
if response.status_code == 200:
    # Print the prediction result
    print("Predictions:", response.json()['predictions'])
else:
    print("Error:", response.text)

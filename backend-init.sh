#!/bin/bash
sudo apt update 
sudo apt install -y python3-pip
pip3 install flask mysql-connector-python flask_cors
cat <<EOF > /home/adminuser/app.py
from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)
CORS(app)  # Enable CORS for your Flask app

db = mysql.connector.connect(
    host="10.0.3.4",  # Replace with database VM's private IP
    user="nani",
    password="Password@123",
    database="userdetails"
)

@app.route('/add_user', methods=['POST'])
def add_user():
    # Get JSON data from POST request
    data = request.get_json()

    # Extract fields from JSON data
    name = data.get('name')
    age = data.get('age')
    email = data.get('email')

    # Validate required fields
    if not name or not age or not email:
        return jsonify({"error": "Name, age, and email are required"}), 400

    # Create cursor object
    cursor = db.cursor()

    try:
        # Execute SQL query to insert user into 'users' table
        cursor.execute("INSERT INTO users (name, age, email) VALUES (%s, %s, %s)", (name, age, email))
        db.commit()  # Commit changes to the database
        return jsonify({"message": "User added"}), 201
    except mysql.connector.Error as err:
        # Handle database errors
        print(f"Error: {err}")
        return jsonify({"error": "Failed to add user"}), 500
    finally:
        cursor.close()  # Close cursor

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

EOF

python3 /home/adminuser/app.py
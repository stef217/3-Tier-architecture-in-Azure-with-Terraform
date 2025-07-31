#!/bin/bash


sudo apt update
sudo apt install -y nginx
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My App</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Add New User</h1>
    <form id="userForm">
       
        <label for="name">Name:</label>
        <input type="text" id="name" name="name">

        <label for="age">Age:</label>
        <input type="number" id="age" name="age">  
        <br><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email">
        <br><br>    
        <button type="submit">Submit</button>
    </form>
    <div id="popup" class="popup"></div>
    <script src="app.js"></script>
</body>
</html>

EOF

cat <<EOF > /var/www/html/styles.css
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    text-align: center;
    margin-top: 50px;
}

.popup {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    padding: 15px;
    background-color: rgba(0, 128, 0, 0.8); /* Green for success */
    color: white;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    z-index: 1000;
    display: none;
}

.popup.error {
    background-color: rgba(255, 0, 0, 0.8); /* Red for error */
}
EOF

cat <<EOF > /var/www/html/app.js
document.getElementById('userForm').addEventListener('submit', function(event) {
    event.preventDefault();

    // Fetch values from the form
    const name = document.getElementById('name').value;
    const age = document.getElementById('age').value;
    const email = document.getElementById('email').value;

    // Prepare data to send in the POST request
    const userData = {
        name: name,
        age: age,
        email: email
    };

    // Send POST request to server
    fetch('http://172.210.58.231:5000/add_user', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(userData)
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
        // Show popup message
        alert('User added successfully!');
    })
    .catch(error => {
        console.error('Error:', error);
        // Show error message
        alert('An error occurred while adding the user.');
    });
});
EOF

sudo rm /var/www/html/index.nginx-debian.html
sudo systemctl restart nginx
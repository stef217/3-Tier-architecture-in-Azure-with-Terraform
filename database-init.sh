#!/bin/bash

# Update package information
sudo apt update

# Install MySQL server
sudo apt install -y mysql-server

# Secure MySQL installation (optional, uncomment if needed)
# sudo mysql_secure_installation

# Create database
sudo mysql -e "CREATE DATABASE userdetails;"

# Create a new user and grant privileges
sudo mysql -e "CREATE USER 'nani'@'%' IDENTIFIED BY 'Password@123';"
sudo mysql -e "GRANT ALL PRIVILEGES ON userdetails.* TO 'nani'@'%';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Create the users table within the userdetails database
sudo mysql -e "USE userdetails; CREATE TABLE users (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255) NOT NULL, age INT NOT NULL, email VARCHAR(255) NOT NULL);"

# Update MySQL configuration to listen on all addresses
sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Restart MySQL service to apply changes
sudo systemctl restart mysql

echo "MySQL setup is complete."
#!/bin/bash

###################################################
# Author: Anil
#
# Date: 21-8-2023
#
# version: v1
#
# This job is to setup Jenkins on vm 
###################################################
set -x

# installing awscli
sudo apt-get update -y
sudo apt-get install zip unzip git -y 
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
/usr/local/bin/aws --version

# Change Host Name to Jenkins
sudo hostnamectl set-hostname Jenkins

# Perform update first
sudo apt update

# Install Java 11
sudo apt install default-jdk -y

# Verify Java Version
java -version

# Maven Installation
sudo apt install maven -y
mvn --version

# Jenkins Setup
# Add Repository key to the system
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Append debian package repo address to the system
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update Ubuntu package
sudo apt update

# Update Linux package
# sudo yum update

# Install Jenkins
sudo apt install jenkins -y

# To check if Jenkins is installed and running,
sudo systemctl status jenkins

# Note: If the Jenkins service is not running or active, run the following command to start it:
# sudo systemctl enable --now jenkins

# Modify Firewall to Allow Jenkins
# Allow Jenkins to communicate by setting up the default UFW firewall.
# Open port 8080 by running the following commands:
sudo ufw allow 8080
sudo ufw status
sudo ufw enable

# Set up Jenkins:
#Follow the steps below to set up Jenkins and start using it:

# 1. Open a web browser, and navigate to your server' IP address. Use the following syntax:
# http://ip_address_or_domain:8080
# Use the actual IP address or domain name for the server you're using Jenkins on. For example, if you're running Jenkins locally, use localhost (127.0.0.1):
# http://localhost:8080

# 2. Obtain the default Jenkins unlock password by opening the terminal and running the following command:
 sudo cat /var/lib/jenkins/secrets/initialAdminPassword


# used this link to host jenkins on ubuntu
# https://phoenixnap.com/kb/install-jenkins-ubuntu 







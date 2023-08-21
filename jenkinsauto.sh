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








































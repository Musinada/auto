#!/bin/bash

###################################################
# Author: Anil
#
# Date: 21-8-2023
#
# version: v1
#
# This job is to setup Docker on vm &
# Docker Jenkins integretion
###################################################
set -x

# installing awscli
sudo apt-get update -y
sudo apt-get install zip unzip git -y 
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
/usr/local/bin/aws --version

# Docker installation steps using default repository from Ubuntu
# Update local packages by executing below command:
sudo apt update

# Install the below packages
sudo apt install gnupg2 pass -y

# gnupg2 is tool for secure communication and data storage. 
# It can be used to encrypt data and to create digital signatures
 
# Install docker
sudo apt install docker.io -y

echo $USER

# Add Ubuntu user to Docker group
sudo usermod -aG docker $USER

# We need to reload shell in order to have new group settings applied. 
# Now you need to logout and log back in command line or execute the below command:

newgrp docker

# The Docker service needs to be setup to run at startup. 
# To do so, type in each command followed by enter:

sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

#####################################################################
# now go to jenkins and do the following things
# Docker plug-in installed in Jenkins.
# Docker pipeline plug-in installed in Jenkins

#Steps:
# Now Login to Jenkins EC2 instance, execute below commands:

# Add jenkins user to Docker group
sudo usermod -a -G docker jenkins

# Restart Jenkins service
sudo service jenkins restart

# Reload system daemon files
sudo systemctl daemon-reload

# Restart Docker service as well

sudo service docker stop
sudo service docker start











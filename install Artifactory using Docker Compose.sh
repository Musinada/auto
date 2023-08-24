#!/bin/bash

##################################################################################
# Author: Anil
#
# Date: 24-8-23
#
# version: 1.0
#
# this job is to install Artifactory using Docker Compose | Install Artifactory using Docker Compose on Ubuntu 22.0.4 | 
# How to Setup JFrog Artifactory using Docker-Compose
#
# Pre-requisites:
# Ubuntu EC2 up and running with at least t2.medium (4GB RAM), 2GB will not work
# Port 8081, 8082 is opened in security firewall rule
# instance should have docker-compose installed
##################################################################################

set -x

# Change Host Name to Artifactory
sudo hostnamectl set-hostname Artifactory

# Perform System update
sudo apt update

# Install Docker-Compose
sudo apt install docker-compose -y

# Create docker-compose.yml
# this yml has all the configuration for installing Artifactory on Ubuntu EC2.
sudo vi docker-compose.yml 

######################################################################################
# (Copy the below code high-lighted in yellow color)
# version: "3.3"
# services:
#   artifactory-service:
#    image: docker.bintray.io/jfrog/artifactory-oss:7.49.6
#    container_name: artifactory
#    restart: always
#    networks:
#      - ci_net
#    ports:
#      - 8081:8081
#      - 8082:8082
#    volumes:
#      - artifactory:/var/opt/jfrog/artifactory

# volumes:
#  artifactory:
# networks:
#  ci_net:

# Save the file by entering :wq!
################################################################################################

# Now execute the compose file using Docker compose command to start Artifactory Container
sudo docker-compose up -d 

# Make sure Artifactory is up and running
sudo docker-compose logs --follow

# Once you see the message, that's it. Artifactory is been setup successfully. Now press Control C and enter to come out of the above screen.

# Check Artifactory is up and running by typing below command:
curl localhost:8081

# This confirms that Artifactory is up and running locally.

############################################################################################
# How to access Artifactory in the browser?

# Now access Artifactory UI by going to browser and enter public dns name with port 8081
# http://change to_artifactory_publicdns_name:8081
############################################################################################

# How to stop Artifactory container
sudo docker-compose down

#############################################################################################
# How to integrate Artifactory with Jenkins?
# https://www.coachdevops.com/2023/01/how-to-integrate-artifactory-with.html
#############################################################################################













#!/bin/bash

###################################################
# Author: Anil
#
# Date: 30-8-2023
#
# version: v1.0
#
# This job is to configure Jenkins and DockerSlave on same vm &
# Docker Jenkins integration
###################################################


set -x


# Install Jenkins.
# Pre-Requisites:

# Java (JDK)
# Run the below commands to install Java and Jenkins
# Install Java

sudo apt update
sudo apt install openjdk-11-jre
# Verify Java is Installed

java -version
# Now, you can proceed with installing Jenkins

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins


# After you login to Jenkins, - Run the command to copy the Jenkins Admin Password - 
sudo cat /var/lib/jenkins/secrets/initialAdminPassword 
#Enter the Administrator password


# Docker Slave Configuration
# Run the below command to Install Docker

sudo apt update
sudo apt install docker.io

# Docker Demon:
# the docker typically runs on deamon process ie., single process or single source of tool for docker.
# amd this demon process is not accessible with other users. 
# only root user will have access to this deamon.

#To do that,
#Grant Jenkins user and Ubuntu user permission to docker deamon.

sudo su - 
usermod -aG docker jenkins
usermod -aG docker ubuntu
systemctl restart docker


su - jenkins
docker run hello-world
# here it shows the permission id denied
# now, check what is going there

logout   # from jenkins 

# comes to root user

usermod -aG docker jenkins
# here it grants the access are not

# now swith to jenkins user
su - jenkins
docker run hello-world

# and it starts to pull the image from docker registery, and the image gets download. here the demon was restarted.

# Once you are done with the above steps, it is better to restart Jenkins.
http://<ec2-instance-public-ip>:8080/restart

# The docker agent configuration is now successful.

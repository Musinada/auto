
###################################################
# Author: Anil
#
# Date: 21-8-2023
#
# version: v1
#
# This job is to install and Automate EKS Cluster using Bootstrap Script | 
# Bootstrap script for setting up Jenkins, Docker and EKS Cluster in AWS cloud
#
###################################################

# Pre-requisites:
# You need to create an IAM role with Administrator Access policy and attach that IAM role to EC2 instance while you provision.

# Click on Advanced Details and under user data:
# Script for setting up Jenkins, Docker and setting EKS cluster using eksctl command:

#!/bin/bash

# Shell script for installing Java,  Maven, Jenkins, EKS Cluster in Ubuntu EC2 instance

# Command for installing Java 11
sudo apt-get update
sudo apt-get install default-jdk -y

# Command for installing maven
sudo apt-get install maven -y


# Script for Jenkins installation
# Add Repository key to the system

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
Append debian package repo address to the system

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update


# Install Jenkins
sudo apt-get install jenkins -y

echo "Jenkins installed successfully.."

##################################################################
#Install Docker

sudo apt-get update

#Install the below packages
sudo apt install gnupg2 pass -y

#Install docker
sudo apt install docker.io -y

#Add Ubuntu user to Docker group
sudo usermod -aG docker $USER

# start Docker
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

sudo usermod -a -G docker jenkins
sudo service jenkins restart

#Reload system daemon files
sudo systemctl daemon-reload

#Restart Docker service as well
sudo service docker stop
sudo service docker start

##############################################################
# Install AWS CLI

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
sudo apt install unzip
sudo unzip awscliv2.zip  
sudo ./aws/install
aws --version

##############################################################
#Install eksctl on Linux

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

#Move the extracted binary to /usr/local/bin. 

sudo mv /tmp/eksctl /usr/local/bin
eksctl version

##############################################################
# Install Kubectl

sudo curl --silent --location -o /usr/local/bin/kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl
kubectl version --short --client

##############################################################
# Install Helm

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh
helm version --client

sudo su - jenkins

##############################################################
#Create EKS cluster using eksctl command

eksctl create cluster --name demo-eks --region ap-south-1 --nodegroup-name my-nodes --node-type t3.small --managed --nodes 2 




# https://www.coachdevops.com/2022/05/automate-eks-cluster-using-script-shell.html






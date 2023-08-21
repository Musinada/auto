#!/bin/bash

###################################################
# Author: Anil
#
# Date: 21-8-2023
#
# version: v1
#
# This job is to install all the required software’s for eks cluster 
###################################################
set -x

# installing awscli
sudo apt-get update -y
sudo apt-get install zip unzip git -y 
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
/usr/local/bin/aws --version

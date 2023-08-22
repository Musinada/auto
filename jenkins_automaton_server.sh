#!/bin/bash

##########################################################################
# Author: Anil
# Date: 22-8-2023
# version: v1.0
# This job is to host a jenkins automation server on above Ubuntu 22.04 VM
##########################################################################
set -x
# Installing Java
sudo apt update
sudo apt install openjdk-11-jre
java --version

# Installing Jenkins
# add the GPG key for the jenkins repository
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

#add the Jenkins repository to your system
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Now run the apt command below to update and refresh all your system repositories
sudo apt update

# Next, you can install Jenkins using the apt command 
sudo apt install jenkins 

# run the following command to start and enable the Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Now verify the Jenkins service
sudo systemctl status jenkins

##############################################################################################

# Setting Up Apache2 as a Reverse Proxy

# At this point, the Jenkins is up and running on the default address localhost with the port 8080. 
# Now, you will be installing and configuring the Apache2 web server as a reverse proxy for jenkins.
#The Apache2 web server will be running in front of the Jenkins service and open the standard HTTP and HTTPS ports for client access.

# Run the apt command below to install the apache2 package 
# Input Y to confirm the installation and press ENTER to continue
sudo apt install apache2

# Now after installation is completed, to enable some apache2 modules that are needed for reverse proxy configuration
sudo a2enmod ssl rewrite headers proxy proxy_http

# Next, create a new virtual host configuration /etc/apache2/sites-available/jenkins.conf using nano editor.
sudo nano /etc/apache2/sites-available/jenkins.conf

# Add the following configuration to the file. 
# And make sure to change the domain name and path of SSL certificates.

     #######  #########  ##############  ########  ##########  #############    
          # copy the below text in jenkins.conf file #    
    ########## ##########  #########  ##########  ###########  #############
# <VirtualHost *:80>
#    ServerAdmin  webmaster@localhost
#    Redirect permanent / https://jenkins.makdomain.io/
# </VirtualHost>

# <VirtualHost *:443>
#    SSLEngine On
#    SSLCertificateFile /etc/letsencrypt/live/jenkins.makdomain.io/fullchain.pem
#    SSLCertificateKeyFile /etc/letsencrypt/live/jenkins.makdomain.io/privkey.pem
#    ServerAdmin  webmaster@localhost
#    ProxyRequests     Off
#    ProxyPreserveHost On
#    AllowEncodedSlashes NoDecode
#    <Proxy *>
#        Order deny,allow
#        Allow from all
#    </Proxy>
#    ProxyPass         /  http://localhost:8080/ nocanon
#    ProxyPassReverse  /  http://localhost:8080/
#    ProxyPassReverse  /  http://jenkins.makdomain.io/
#    RequestHeader set X-Forwarded-Proto "https"
#    RequestHeader set X-Forwarded-Port "443"
# </VirtualHost>
     ##########  ###########  ##############  #########  ###########  ##########
# Save and close the file when you are done


# run the following command to activate the virtual host configuration jenkins.conf.
sudo a2ensite jenkins.conf

# After that, check and verify all of your Apache2 configurations
# Be sure you get the output message such as "Syntax OK", 
# which means all of your Apache2 configurations is correct.
sudo apachectl configtest


# Lastly, restart the Apache2 service and apply new changes to your Apache2 configuration
sudo systemctl restart apache2
#Now the Apache2 web server is up and running with the reverse proxy configuration for Jenkins.

####################################################################################################

# Start Jenkins Installation, to check and get the jenkins initial password.

ls /var/lib/jenkins/secrets/initialAdminPassword
cat /var/lib/jenkins/secrets/initialAdminPassword

# Open your web browser and visit the URL installation for your Jenkins installation (hwdomain.io)
# (e.g https://jenkins.makdomain.io).


# https://www.howtoforge.com/tutorial/ubuntu-jenkins-automation-server/






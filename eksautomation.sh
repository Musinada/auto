#!/bin/bash

###################################################
# Author: Anil
#
# Date: 18-8-2023
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

# installing EKSCTL
curl --silent --location https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# Install Kubectl
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl 
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
kubectl

# Install terraform 
# Amazon Linux based
# Install yum-config-manager to manage your repositories.
# sudo yum install -y yum-utils
# Use yum-config-manager to add the official HashiCorp Linux repository.
# sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
# Install.
# sudo yum -y install terraform

# Ubuntu OS
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add

sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update -y && sudo apt-get install terraform -y

# {adding a repository and update it to install the terraform}
terraform –version

# Installing Helm Charts

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null 

sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# install Git

# sudo yum install git -y

sudo apt-get install git -y

#Install prometheus using helm charts

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts  
helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics 
helm repo update &amp;&amp; kubectl create ns infra 
helm install prometheus prometheus-community/prometheus -n infra --set server.service.type=LoadBalancer 
kubectl get all -n infra 


# Install Grafana using helm charts

helm repo add bitnami https://charts.bitnami.com/bitnami &amp;&amp; 
helm install grafana bitnami/grafana -n infra --set service.type=LoadBalancer –set service.ports.grafana=3200 &amp;&amp; 
kubectl get all -n infra 

# Install Sonarqube using helm charts

helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube 
helm repo update  
helm install sonarqube sonarqube/sonarqube -n infra --set service.type=LoadBalancer 
 kubectl get all -n infra

# Install Nexus using helm charts

helm repo add sonatype https://sonatype.github.io/helm3-charts/ 
helm repo update 
helm install nexus-rm sonatype/nexus-repository-manager -n infra --set service.type=LoadBalancer 
kubectl get all -n infra

# Install Jenkins using helm charts

helm repo add bitnami https://charts.bitnami.com/bitnami 
helm install jenkins bitnami/jenkins -n infra --set service.type=LoadBalancer 
kubectl get all -n infra 

# Install Vault using helm charts

helm repo add hashicorp https://helm.releases.hashicorp.com 
helm repo update 
helm install vault hashicorp/vault -n infra --set server.service.type=LoadBalancer 
kubectl get all -n infra 


# Install EFK using helm charts

# stage("Deploy EFK") {
# sh """
#     cat &lt;&lt; EOF &gt; kibana.yaml
# files:
#  kibana.yml:
#    server.name: kibana
#    server.host: "0"
#    elasticsearch.hosts: http://elasticsearch-client:9200
#service:
#  type: LoadBalancer
# externalPort: 5601

helm repo add stable https://charts.helm.sh/stable 
helm install elasticsearch stable/elasticsearch -n infra --set client.serviceType=LoadBalancer 
helm install kibana stable/kibana -n infra -f kibana.yaml 
helm install fluentd stable/fluentd-elasticsearch -n infra 
kubectl get all -n infra 


# Install Jaeger using helm charts

helm repo add jaegertracing https://jaegertracing.github.io/helm-charts 
helm install jaeger jaegertracing/jaeger -n infra --set query.service.type=LoadBalancer 
kubectl get all -n infra"

# Install Consul Deployment using helm charts

helm repo add hashicorp https://helm.releases.hashicorp.com 
helm repo update 
helm install consul hashicorp/consul --set global.name=consul -n infra --set server.replicas=1 --set ui.service.type=LoadBalancer 
kubectl get all -n infra 
 



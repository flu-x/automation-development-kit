#!/bin/zsh

jq_status=$(jq --version | echo $?)
var_path=$(which minikube)
var_unix_path="/usr/local/bin/minikube"

if [ "$jq_status" -eq 0 ]; then
  echo "---- jq is already installed ----"
#  brew upgrade jq
else
  brew install jq
fi

# Check if minikube is installed in the system
if [ "$var_path" = "$var_unix_path" ]; then
  echo "---- Minikube is already installed ----"
else
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
fi

# Start minikube
minikube start

# Check status of minikube
minikube status --output json
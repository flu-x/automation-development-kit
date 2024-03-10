#!/bin/bash

var_path=$(which minikube)
var_unix_path="/usr/local/bin/minikube"

# Check if minikube is installed in the system
if [ "$var_path" = "$var_unix_path" ]; then
  echo "---- Minikube is already installed ----"
else
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
fi

# Start minikube if not already started
var_kubeconfig=$(minikube status --output json | jq -r ".Kubeconfig")
if [ "$var_kubeconfig" = Configured ]; then
  echo "---- Minikube already running in start mode ----"
else
  minikube start
fi

# Check status of minikube
echo "---- Minikube status ----"
minikube status --output json

echo ""

# Check minikube version
echo "---- Minikube version ----"
minikube version --output json

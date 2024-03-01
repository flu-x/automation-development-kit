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
  brew install minikube
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
echo "$(minikube status --output json)"

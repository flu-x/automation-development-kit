#!/bin/bash

jq --version
jq_status=$?

# If the os type starts with darwin then execute the installer script for mac
if [[ "$OSTYPE" =~ ^darwin ]]; then
    if [ "$jq_status" -eq 0 ]; then
      echo "---- jq is already installed ----"
#      brew upgrade jq
      echo "---- jq upgrade complete ----"
    else
      brew install jq
      echo "---- jq installed ----"
    fi

    # Add file permission to mac installation
    chmod +x "$(jq -r ".file_path.mac_installation" adk/configurations/config.json)"

    # Execute script to install minikube on mac
    adk/scripts/minikubeinstaller/checkinstallermac.sh
fi

# If the os type starts with linux then execute the installer script for linux
if [[ "$OSTYPE" =~ ^linux ]]; then
    if [ "$jq_status" -eq 0 ]; then
      echo "---- jq is already installed ----"
    else
      sudo apt-get install -y jq
    fi

    # Add file permission to mac installation
    chmod +x "$(jq -r ".file_path.linux_installation" adk/configurations/config.json)"

    # Execute script to install minikube on mac
    adk/scripts/minikubeinstaller/checkinstallerlinux.sh
fi

# Deploy Selenium Hub on Kubernetes Pod
kubectl create -f selenium-hub-deployment.yaml

# Deploy Kubernetes services on Kubernetes Pod
kubectl create -f selenium-hub-svc.yaml

# Deploy Selenium Chrome and Firefox container on another pod
kubectl create -f selenium-node-chrome-deployment.yaml
kubectl create -f selenium-node-firefox-deployment.yaml

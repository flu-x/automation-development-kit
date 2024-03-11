#!/bin/bash

configpath="adk/configurations/config.json"

function install_packages() {
  jq --version
  jq_status=$?

  # If the os type starts with darwin then execute the installer script for mac
  if [[ "$OSTYPE" =~ ^darwin ]]; then
      if [ "$jq_status" -eq 0 ]; then
        echo "---- jq is already installed ----"
        brew upgrade jq
        echo "---- jq upgrade complete ----"
      else
        brew install jq
        echo "---- jq installed ----"
      fi

      # Add file permission to mac installation
      chmod +x "$(jq -r '.file_path.mac_installation' $configpath)"

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
      chmod +x "$(jq -r '.file_path.linux_installation' $configpath)"

      # Execute script to install minikube on mac
      adk/scripts/minikubeinstaller/checkinstallerlinux.sh
  fi
}

function deploy_k8sgrid() {
  # Deploy Selenium Hub on Kubernetes Pod
  kubectl create -f "$(jq -r '.file_path.selenium-hub' $configpath)"

  # Deploy Kubernetes services on Kubernetes Pod
  kubectl create -f "$(jq -r '.file_path.selenium-hub-services' $configpath)"

  # Deploy Selenium Chrome and Firefox container on another pod
  kubectl create -f "$(jq -r '.file_path.selenium-node.node-chrome' $configpath)"
  kubectl create -f "$(jq -r '.file_path.selenium-node.node-firefox' $configpath)"

  # Get the ip address for the selenium hub and node
  minikube service selenium-hub --url
}

# Validate that if an argument is passed or not
if [ $# -eq 0 ]; then echo "No option is passed as argument"; fi

# Parse command line argument to run functions accordingly
for i in "$@"; do
  case $i in
    --install) install_packages
               break
               ;;
    --deploy) deploy_k8sgrid
              break
              ;;
    *) echo "---- error: Option not available ----"
  esac
done

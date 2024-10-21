#!/bin/bash

install_docker() {
    echo "Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    sudo docker run hello-world
}

# Function to install gcloud CLI
install_gcloud() {
    echo "Installing gcloud CLI..."
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
    tar -xf google-cloud-cli-linux-x86_64.tar.gz
    ./google-cloud-sdk/install.sh
    ./google-cloud-sdk/bin/gcloud init
}

# Function to install AWS CLI
install_aws() {
    echo "Installing AWS CLI..."
    sudo apt-get update
    sudo apt-get install -y curl unzip

    # Download and install AWS CLI
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

    # Verify AWS CLI installation
    if command -v aws &> /dev/null; then
        echo "AWS CLI installed successfully."
    else
        echo "AWS CLI installation failed."
    fi
}

# Function to install azcopy
install_azcopy() {
    echo "Installing azcopy..."
    curl -sSL -O https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb
    sudo apt-get update
    sudo apt-get install -y azcopy
}

# Function to install Azure CLI
install_azure_cli() {
    echo "Installing Azure CLI..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}
main() {
    install_docker
    install_gcloud
    install_aws
    install_azcopy
    install_azure_cli
}

main

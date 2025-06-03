#!/bin/bash
sudo -s
su ec2-user

# Update system
sudo yum update -y

# Install Golang (required for eks-node-viewer)
sudo yum install golang -y

# Verify AWS CLI (usually pre-installed)
echo "Verifying AWS CLI version..."
aws --version 

# Install TMUX
sudo yum install -y tmux 

# Install EKSCTL
echo "Installing EKSCTL..."

ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_${PLATFORM}.tar.gz" 

curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check 
tar -xzf eksctl_${PLATFORM}.tar.gz -C /tmp && rm eksctl_${PLATFORM}.tar.gz 
sudo mv /tmp/eksctl /usr/local/bin 
eksctl --version 

# Install Kubectl
echo "Installing Kubectl..."

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" 

echo "$(cat kubectl.sha256) kubectl" | sha256sum --check 

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl 
kubectl version --client 

# Install Helm
echo "Installing Helm..."
wget https://get.helm.sh/helm-v3.18.1-linux-amd64.tar.gz 
tar -zxvf helm-v3.18.1-linux-amd64.tar.gz 
sudo mv linux-amd64/helm /usr/local/bin/helm 
helm version 

# Install Cosign
echo "Installing Cosign..."

LATEST_VERSION=$(curl https://api.github.com/repos/sigstore/cosign/releases/latest | grep tag_name | cut -d : -f2 | tr -d "v\", ") 

curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign-${LATEST_VERSION}-1.x86_64.rpm" 
sudo rpm -ivh cosign-${LATEST_VERSION}-1.x86_64.rpm 

# Install Istioctl (Latest version)
echo "Installing Istioctl..."
curl -L https://istio.io/downloadIstio | sh 

ISTIO_DIR=$(find /home/ec2-user -maxdepth 1 -type d -name "istio-*" | head -n 1) 

if [ -d "$ISTIO_DIR" ]; then
    echo "export PATH=\$PATH:${ISTIO_DIR}/bin" >> ~/.bashrc 
    echo "export PATH=\$PATH:${ISTIO_DIR}/bin" | sudo tee -a /etc/profile 
    export PATH=$PATH:${ISTIO_DIR}/bin
    echo "Istio installed to $ISTIO_DIR. Path updated."
else
    echo "Could not find Istio directory."
fi
istioctl x precheck 

# Install eks-node-viewer
echo "Installing eks-node-viewer..."

go install github.com/awslabs/eks-node-viewer/cmd/eks-node-viewer@latest 
sudo mv -v ~/go/bin/eks-node-viewer /usr/local/bin 
eks-node-viewer --version || true 
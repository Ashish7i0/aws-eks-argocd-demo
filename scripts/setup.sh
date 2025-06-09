#!/bin/bash
set -e

# Variables
CLUSTER_NAME="eks-argocd-demo"
REGION="us-west-2"

echo "Setting up AWS EKS with ArgoCD demo project..."

# Initialize Terraform
echo "Initializing Terraform..."
cd ../terraform
terraform init

# Apply Terraform to create infrastructure
echo "Creating AWS infrastructure with Terraform..."
terraform apply -auto-approve

# Configure kubectl
echo "Configuring kubectl..."
aws eks update-kubeconfig --region $REGION --name $CLUSTER_NAME

# Install ArgoCD
echo "Installing ArgoCD..."
kubectl apply -f ../kubernetes/argocd/install.yaml

# Wait for ArgoCD to be ready
echo "Waiting for ArgoCD to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

# Get ArgoCD admin password
echo "Getting ArgoCD admin password..."
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo "ArgoCD admin password: $ARGOCD_PASSWORD"

# Get ArgoCD URL
echo "Getting ArgoCD URL..."
ARGOCD_URL=$(kubectl get svc argocd-server -n argocd -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")
echo "ArgoCD URL: http://$ARGOCD_URL"

# Create ArgoCD application
echo "Creating ArgoCD application..."
kubectl apply -f ../kubernetes/argocd/application.yaml

echo "Setup complete!"
echo "Access ArgoCD at http://$ARGOCD_URL with username 'admin' and password '$ARGOCD_PASSWORD'"
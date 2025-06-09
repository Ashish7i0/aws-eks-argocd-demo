# Setup Instructions

This document provides step-by-step instructions for setting up the AWS EKS with ArgoCD demo project.

## Prerequisites

1. AWS CLI installed and configured with appropriate permissions
2. Terraform installed (v1.0.0+)
3. kubectl installed
4. Docker installed
5. GitHub account

## Step 1: Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/aws-eks-argocd-demo.git
cd aws-eks-argocd-demo
```

## Step 2: Configure AWS Credentials

Ensure your AWS credentials are configured:

```bash
aws configure
```

## Step 3: Update Configuration Files

1. Update the GitHub repository URL in `kubernetes/argocd/application.yaml` with your own repository URL.
2. Update the AWS region and cluster name in `terraform/variables.tf` if needed.

## Step 4: Deploy Infrastructure with Terraform

```bash
cd terraform
terraform init
terraform apply
```

## Step 5: Configure kubectl

```bash
aws eks update-kubeconfig --region us-west-2 --name eks-argocd-demo
```

## Step 6: Install ArgoCD

```bash
kubectl apply -f ../kubernetes/argocd/install.yaml
```

## Step 7: Access ArgoCD UI

Wait for the ArgoCD server to be ready:

```bash
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd
```

Get the ArgoCD server URL:

```bash
kubectl get svc argocd-server -n argocd -o jsonpath="{.status.loadBalancer.ingress[0].hostname}"
```

Get the initial admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Access the ArgoCD UI using the URL and login with username `admin` and the password obtained above.

## Step 8: Deploy the Application with ArgoCD

```bash
kubectl apply -f ../kubernetes/argocd/application.yaml
```

## Step 9: Set up GitHub Actions

1. Add the following secrets to your GitHub repository:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

2. Push your code to GitHub to trigger the CI/CD pipeline.

## Step 10: Verify Deployment

```bash
kubectl get pods -n demo
```

Access the application using the ALB URL:

```bash
kubectl get ingress -n demo
```
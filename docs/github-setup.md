# GitHub Repository Setup

This document provides instructions for setting up your GitHub repository with the necessary secrets for CI/CD.

## Required GitHub Secrets

To enable the CI/CD pipeline to deploy to AWS, you need to add the following secrets to your GitHub repository:

1. Go to your GitHub repository
2. Click on "Settings" > "Secrets and variables" > "Actions"
3. Add the following secrets:

| Secret Name | Description |
|-------------|-------------|
| `AWS_ACCESS_KEY_ID` | Your AWS Access Key ID with permissions to create and manage EKS, ECR, and other AWS resources |
| `AWS_SECRET_ACCESS_KEY` | Your AWS Secret Access Key corresponding to the Access Key ID |

## Required AWS Permissions

The AWS user associated with the credentials above should have the following permissions:

- AmazonECR-FullAccess
- AmazonEKSClusterPolicy
- IAMFullAccess
- AmazonVPCFullAccess
- CloudWatchLogsFullAccess

You can create a custom policy or use AWS managed policies to grant these permissions.

## Setting up AWS CLI locally

If you want to interact with your AWS resources locally, make sure to configure AWS CLI:

```bash
aws configure
```

Enter your AWS Access Key ID, Secret Access Key, default region (us-west-2), and output format (json).

## Connecting to your EKS cluster

After the infrastructure is deployed, you can connect to your EKS cluster using:

```bash
aws eks update-kubeconfig --region us-west-2 --name eks-argocd-demo
```
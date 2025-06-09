# AWS EKS with ArgoCD Demo

This repository demonstrates a complete DevOps workflow using AWS EKS, ECR, and ArgoCD for GitOps-based deployments.

## Architecture

![Architecture Diagram](docs/architecture.png)

## Features

- Infrastructure as Code using Terraform
- Kubernetes cluster on AWS EKS
- Container registry with AWS ECR
- GitOps with ArgoCD
- CI/CD with GitHub Actions
- Sample microservice application

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform installed
- kubectl installed
- Docker installed

## Getting Started

1. Clone this repository
2. Follow the setup instructions in [docs/setup.md](docs/setup.md)
3. Deploy the infrastructure with Terraform
4. Set up ArgoCD
5. Deploy the sample application

## Project Structure

- `/terraform` - Terraform code for provisioning AWS resources
- `/kubernetes` - Kubernetes manifests and ArgoCD configuration
- `/app` - Sample application code
- `/scripts` - Utility scripts
- `/.github/workflows` - CI/CD pipeline definitions

## License

MIT
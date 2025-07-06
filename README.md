# ECR Secret Updater Helm Chart

This Helm chart manages AWS ECR image pull secrets in any Kubernetes cluster, whether on AWS (EKS) or self-managed.

## Features

- Works in **any Kubernetes cluster** using AWS access keys.
- Option to **create a new service account** or use the **default one**.
- Optionally **patches default service accounts** in target namespaces.
- Deploys in a **separate namespace** (default: `aws-ecr-secret-updater`).
- GitHub Actions for Docker image and Helm chart publishing.

## Prerequisites

- Helm 3
- A Kubernetes cluster
- AWS account with ECR access
- AWS access key ID and secret access key with `ecr:GetAuthorizationToken` permission

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/aws-ecr-secret-updater.git
   cd aws-ecr-secret-updater
   ```

2. Customize Values: Create a my-values.yaml file:
    ```yaml
    namespace: aws-ecr-secret-updater

    aws:
        region: "us-west-2"
        accountId: "123456789012"
        accessKeyId: "YOUR_ACCESS_KEY_ID"
        secretAccessKey: "YOUR_SECRET_ACCESS_KEY"

    namespaces:
        - default
        - my-namespace

    serviceAccount:
        create: true  # Set to false to use default service account
        patchDefault: true  # Patch default service accounts in target namespaces
    ```

3. Install the Helm chart:
    ```bash
    helm install aws-ecr-secret-updater . -f my-values.yaml -n aws-ecr-secret-updater --create-namespace
    ```

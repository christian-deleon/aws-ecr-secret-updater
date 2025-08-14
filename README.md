# ECR Secret Updater Helm Chart

This Helm chart manages AWS ECR image pull secrets in any Kubernetes cluster, whether on AWS (EKS) or self-managed.

## Installation

1. Add the Helm repository:

   ```bash
   helm repo add aws-ecr-secret-updater https://christian-deleon.github.io/aws-ecr-secret-updater
   ```

2. Customize Values: Create a copy of the [values.yaml](values.yaml) file and update the values to your needs.

3. Install the Helm chart:

    ```bash
    helm install aws-ecr-secret-updater aws-ecr-secret-updater/aws-ecr-secret-updater -f values.yaml -n aws-ecr-secret-updater --create-namespace
    ```

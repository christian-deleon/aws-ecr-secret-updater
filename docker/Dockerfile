FROM alpine:3.14

# Install dependencies
RUN apk add --no-cache curl unzip bash

# Install AWS CLI
RUN curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Install kubectl
RUN curl -sLO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Copy and configure the update script
COPY update-ecr-secret.sh /app/update-ecr-secret.sh
RUN chmod +x /app/update-ecr-secret.sh

WORKDIR /app

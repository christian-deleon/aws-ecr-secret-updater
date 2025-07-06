#!/bin/sh -e


REGION=$AWS_REGION
ACCOUNT_ID=$AWS_ACCOUNT_ID
REGISTRY="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"
PASSWORD=$(aws ecr get-login-password --region $REGION)


for ns in $NAMESPACES; do
  echo "Updating secret in namespace: $ns"

  # Create or update the secret
  kubectl create secret docker-registry $SECRET_NAME \
    --docker-server=$REGISTRY \
    --docker-username=AWS \
    --docker-password=$PASSWORD \
    --dry-run=client -o yaml | kubectl apply -f - -n $ns

  # Patch the default service account if enabled
  if [ "$PATCH_DEFAULT_SA" = "true" ]; then
    echo "Patching default service account in namespace: $ns"
    kubectl patch serviceaccount default -n $ns --type merge -p "{\"imagePullSecrets\": [{\"name\": \"$SECRET_NAME\"}]}"
  fi
done

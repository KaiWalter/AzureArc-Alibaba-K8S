#!/bin/bash

if ! az account show -o tsv ; then
    az login --use-device-code
fi

az account set -s $AZURE_SUBSCRIPTION_ID

az k8sconfiguration create \
    --name cluster-config \
    --cluster-name azure-arc-poc --resource-group $AZURE_RESOURCE_GROUP \
    --operator-instance-name cluster-config --operator-namespace cluster-config \
    --repository-url https://github.com/Azure/arc-k8s-demo \
    --scope cluster --cluster-type connectedClusters
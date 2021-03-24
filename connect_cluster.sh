#!/bin/bash

if ! az account show -o tsv ; then
    az login --use-device-code
fi

az account set -s $AZURE_SUBSCRIPTION_ID

az connectedk8s connect --name azure-arc-poc --resource-group $AZURE_RESOURCE_GROUP --location $AZURE_LOCATION

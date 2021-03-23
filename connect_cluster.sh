#!/bin/bash
az login --use-device-code
az account set -s $AZURE_SUBSCRIPTION_ID
az connectedk8s connect --name azure-arc-poc --resource-group $AZURE_RESOURCE_GROUP --location $AZURE_LOCATION

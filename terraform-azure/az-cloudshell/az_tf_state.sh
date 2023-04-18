#!/bin/bash

RESOURCE_GROUP_NAME=tfstate
STORAGE_ACCOUNT_NAME=tfstate4376
read -p "CONTAINER_NAME:  " CONTAINER_NAME
echo $CONTAINER_NAME
# Create resource group
#az group create --name $RESOURCE_GROUP_NAME --location southeastasia

# Create storage account
#az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
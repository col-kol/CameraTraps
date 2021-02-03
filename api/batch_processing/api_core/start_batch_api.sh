#!/bin/sh

# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Get the credentials from KeyVault

# run `source start_batch_api.sh` to persist the credentials as env variables in the
# current shell for easy debugging by launching the Flask app separately.

# need "-o tsv" for the Azure CLI queries to get rid of quote marks

SUBSCRIPTION=74d91980-e5b4-4fd9-adb6-263b8f90ec5b
KEY_VAULT_NAME=cameratraps

# A URL and a code to use for logging in on the browser will be displayed
echo Log in to your Azure account via the CLI. A browser window should open shortly...
az login

APP_TENANT_ID=$(az keyvault secret show --name batch-api-tenant-id --subscription $SUBSCRIPTION --vault-name $KEY_VAULT_NAME --query value -o tsv)
echo APP_TENANT_ID read from KeyVault
export APP_TENANT_ID

APP_CLIENT_ID=$(az keyvault secret show --name batch-api-client-id --subscription $SUBSCRIPTION --vault-name $KEY_VAULT_NAME --query value -o tsv)
echo APP_CLIENT_ID read from KeyVault
export APP_CLIENT_ID

APP_CLIENT_SECRET=$(az keyvault secret show --name batch-api-client-secret --subscription $SUBSCRIPTION --vault-name $KEY_VAULT_NAME --query value -o tsv)
echo APP_CLIENT_SECRET read from KeyVault
export APP_CLIENT_SECRET

# blob storage account with containers for scripts and job outputs
export STORAGE_ACCOUNT_NAME=cameratrap

STORAGE_ACCOUNT_KEY=$(az keyvault secret show --name cameratrap-storage-account-key --subscription $SUBSCRIPTION --vault-name $KEY_VAULT_NAME --query value -o tsv)
echo STORAGE_ACCOUNT_KEY read from KeyVault
export STORAGE_ACCOUNT_KEY

# Azure Batch
export BATCH_ACCOUNT_NAME=cameratrapssc
export BATCH_ACCOUNT_URL=https://cameratrapssc.southcentralus.batch.azure.com

# Azure Container Registry - Azure Batch gets the Docker image from here
export REGISTRY_SERVER=cameratracrsppftkje.azurecr.io

REGISTRY_PASSWORD=$(az keyvault secret show --name registry-password --subscription $SUBSCRIPTION --vault-name $KEY_VAULT_NAME --query value -o tsv)
echo REGISTRY_PASSWORD read from KeyVault
export REGISTRY_PASSWORD

# for App Configuration
APP_CONFIG_CONNECTION_STR=$(az keyvault secret show --name camera-trap-app-config-connection-str --subscription $SUBSCRIPTION --vault-name $KEY_VAULT_NAME --query value -o tsv)
echo APP_CONFIG_CONNECTION_STR read from KeyVault
export APP_CONFIG_CONNECTION_STR

export FLASK_APP=server
export FLASK_ENV=development

#flask run -p 5000 --eager-loading --no-reload

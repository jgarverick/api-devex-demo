#! /bin/bash
apimID=$(az apim show --name $1 --resource-group $2 --query id --output tsv)

apiIDs="$apimID/apis/*"

az apic service import-from-apim --service-name apic-api-devex-demo --resource-group $2 --source-resource-ids $apiIDs

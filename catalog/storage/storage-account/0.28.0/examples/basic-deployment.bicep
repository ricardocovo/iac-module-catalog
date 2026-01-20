// Basic deployment of Storage Account
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module storageaccount '../main.bicep' = {
  name: 'storage-account-basic'
  params: {
    name: 'storage-account-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = storageaccount.outputs.resourceId
output name string = storageaccount.outputs.name

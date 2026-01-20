// Production deployment of Storage Account
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module storageaccount '../main.bicep' = {
  name: 'storage-account-prod'
  params: {
    name: 'storage-account-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = storageaccount.outputs.resourceId
output name string = storageaccount.outputs.name

// Production deployment of Virtual Network
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param addressPrefixes array

module virtualnetwork '../main.bicep' = {
  name: 'virtual-network-prod'
  params: {
    name: 'virtual-network-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    addressPrefixes: addressPrefixes
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = virtualnetwork.outputs.resourceId
output name string = virtualnetwork.outputs.name

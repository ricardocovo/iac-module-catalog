// Basic deployment of Virtual Network
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module virtualnetwork '../main.bicep' = {
  name: 'virtual-network-basic'
  params: {
    name: 'virtual-network-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = virtualnetwork.outputs.resourceId
output name string = virtualnetwork.outputs.name

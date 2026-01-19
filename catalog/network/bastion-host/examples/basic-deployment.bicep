// Basic deployment of Azure Bastion
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module bastionhost '../main.bicep' = {
  name: 'bastion-host-basic'
  params: {
    name: 'bastion-host-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = bastionhost.outputs.resourceId
output name string = bastionhost.outputs.name

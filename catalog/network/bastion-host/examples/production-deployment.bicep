// Production deployment of Azure Bastion
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module bastionhost '../main.bicep' = {
  name: 'bastion-host-prod'
  params: {
    name: 'bastion-host-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = bastionhost.outputs.resourceId
output name string = bastionhost.outputs.name

// Production deployment of Container Apps Environment
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param workspaceResourceId string
param infrastructureSubnetId string = ''

module containerappsenv '../main.bicep' = {
  name: 'container-apps-environment-prod'
  params: {
    name: 'container-apps-environment-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    workspaceResourceId: workspaceResourceId
    infrastructureSubnetId: infrastructureSubnetId
    zoneRedundant: true
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = containerappsenv.outputs.resourceId
output name string = containerappsenv.outputs.name

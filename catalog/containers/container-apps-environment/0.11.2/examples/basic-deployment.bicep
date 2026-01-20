// Basic deployment of Container Apps Environment
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'
param workspaceResourceId string

module containerappsenv '../main.bicep' = {
  name: 'container-apps-environment-basic'
  params: {
    name: 'container-apps-environment-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    workspaceResourceId: workspaceResourceId
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = containerappsenv.outputs.resourceId
output name string = containerappsenv.outputs.name

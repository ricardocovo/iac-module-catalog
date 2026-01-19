// Basic deployment of Container App
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module containerapp '../main.bicep' = {
  name: 'container-app-basic'
  params: {
    name: 'container-app-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = containerapp.outputs.resourceId
output name string = containerapp.outputs.name

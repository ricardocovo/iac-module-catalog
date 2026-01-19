// Production deployment of Container App
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module containerapp '../main.bicep' = {
  name: 'container-app-prod'
  params: {
    name: 'container-app-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = containerapp.outputs.resourceId
output name string = containerapp.outputs.name

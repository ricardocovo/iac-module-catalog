// Basic deployment of Private Endpoint
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module privateendpoint '../main.bicep' = {
  name: 'private-endpoint-basic'
  params: {
    name: 'private-endpoint-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = privateendpoint.outputs.resourceId
output name string = privateendpoint.outputs.name

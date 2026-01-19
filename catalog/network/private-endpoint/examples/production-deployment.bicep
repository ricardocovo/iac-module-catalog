// Production deployment of Private Endpoint
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module privateendpoint '../main.bicep' = {
  name: 'private-endpoint-prod'
  params: {
    name: 'private-endpoint-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = privateendpoint.outputs.resourceId
output name string = privateendpoint.outputs.name

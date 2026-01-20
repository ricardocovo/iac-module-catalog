// Basic deployment of Private Endpoint
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'
param subnetResourceId string
param serviceResourceId string
param groupIds array

module privateendpoint '../main.bicep' = {
  name: 'private-endpoint-basic'
  params: {
    name: 'private-endpoint-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    subnetResourceId: subnetResourceId
    serviceResourceId: serviceResourceId
    groupIds: groupIds
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = privateendpoint.outputs.resourceId
output name string = privateendpoint.outputs.name

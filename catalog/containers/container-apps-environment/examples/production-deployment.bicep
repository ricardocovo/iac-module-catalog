// Production deployment of Container Apps Environment
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module containerappsenvironment '../main.bicep' = {
  name: 'container-apps-environment-prod'
  params: {
    name: 'container-apps-environment-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = containerappsenvironment.outputs.resourceId
output name string = containerappsenvironment.outputs.name

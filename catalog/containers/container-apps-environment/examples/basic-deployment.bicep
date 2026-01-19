// Basic deployment of Container Apps Environment
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module containerappsenvironment '../main.bicep' = {
  name: 'container-apps-environment-basic'
  params: {
    name: 'container-apps-environment-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = containerappsenvironment.outputs.resourceId
output name string = containerappsenvironment.outputs.name

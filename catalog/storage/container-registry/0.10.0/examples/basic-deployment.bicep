// Basic deployment of Container Registry
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module containerregistry '../main.bicep' = {
  name: 'container-registry-basic'
  params: {
    name: 'container-registry-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = containerregistry.outputs.resourceId
output name string = containerregistry.outputs.name

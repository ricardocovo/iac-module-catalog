// Production deployment of Container Registry
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module containerregistry '../main.bicep' = {
  name: 'container-registry-prod'
  params: {
    name: 'container-registry-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = containerregistry.outputs.resourceId
output name string = containerregistry.outputs.name

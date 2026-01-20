// Production deployment of Azure AI Search Service
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module searchservice '../main.bicep' = {
  name: 'search-service-prod'
  params: {
    name: 'search-service-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = searchservice.outputs.resourceId
output name string = searchservice.outputs.name

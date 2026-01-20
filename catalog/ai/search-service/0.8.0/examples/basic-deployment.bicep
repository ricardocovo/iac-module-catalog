// Basic deployment of Azure AI Search Service
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module searchservice '../main.bicep' = {
  name: 'search-service-basic'
  params: {
    name: 'search-service-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = searchservice.outputs.resourceId
output name string = searchservice.outputs.name

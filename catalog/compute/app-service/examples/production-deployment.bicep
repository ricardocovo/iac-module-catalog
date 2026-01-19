// Production deployment of App Service (Web App)
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param serverFarmResourceId string

module appservice '../main.bicep' = {
  name: 'app-service-prod'
  params: {
    name: 'app-service-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    serverFarmResourceId: serverFarmResourceId
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = appservice.outputs.resourceId
output name string = appservice.outputs.name

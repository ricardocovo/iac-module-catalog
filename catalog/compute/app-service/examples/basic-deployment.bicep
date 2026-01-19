// Basic deployment of App Service (Web App)
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module appservice '../main.bicep' = {
  name: 'app-service-basic'
  params: {
    name: 'app-service-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = appservice.outputs.resourceId
output name string = appservice.outputs.name

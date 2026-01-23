// Basic deployment of Azure Static Web App
targetScope = 'resourceGroup'

param location string = 'eastus2'
param environment string = 'dev'

module staticWebApp '../main.bicep' = {
  name: 'swa-basic'
  params: {
    name: 'swa-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    skuName: 'Free'
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = staticWebApp.outputs.resourceId
output name string = staticWebApp.outputs.name
output defaultHostname string = staticWebApp.outputs.defaultHostname

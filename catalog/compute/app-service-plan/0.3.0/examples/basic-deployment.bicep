// Basic deployment of App Service Plan
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module appserviceplan '../main.bicep' = {
  name: 'app-service-plan-basic'
  params: {
    name: 'app-service-plan-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = appserviceplan.outputs.resourceId
output name string = appserviceplan.outputs.name

// Production deployment of App Service Plan
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module appserviceplan '../main.bicep' = {
  name: 'app-service-plan-prod'
  params: {
    name: 'app-service-plan-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = appserviceplan.outputs.resourceId
output name string = appserviceplan.outputs.name

// Production deployment of Application Insights
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module applicationinsights '../main.bicep' = {
  name: 'application-insights-prod'
  params: {
    name: 'application-insights-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = applicationinsights.outputs.resourceId
output name string = applicationinsights.outputs.name

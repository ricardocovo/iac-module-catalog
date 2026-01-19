// Basic deployment of Application Insights
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module applicationinsights '../main.bicep' = {
  name: 'application-insights-basic'
  params: {
    name: 'application-insights-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = applicationinsights.outputs.resourceId
output name string = applicationinsights.outputs.name

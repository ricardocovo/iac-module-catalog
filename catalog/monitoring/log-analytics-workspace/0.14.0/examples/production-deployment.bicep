// Production deployment of Log Analytics Workspace
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module loganalyticsworkspace '../main.bicep' = {
  name: 'log-analytics-workspace-prod'
  params: {
    name: 'log-analytics-workspace-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = loganalyticsworkspace.outputs.resourceId
output name string = loganalyticsworkspace.outputs.name

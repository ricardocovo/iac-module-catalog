// Basic deployment of Log Analytics Workspace
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module loganalyticsworkspace '../main.bicep' = {
  name: 'log-analytics-workspace-basic'
  params: {
    name: 'log-analytics-workspace-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = loganalyticsworkspace.outputs.resourceId
output name string = loganalyticsworkspace.outputs.name

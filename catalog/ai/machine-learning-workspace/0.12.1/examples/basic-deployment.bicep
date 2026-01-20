// Basic deployment of Machine Learning Workspace
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'
param storageAccountResourceId string
param keyVaultResourceId string
param applicationInsightsResourceId string

module machinelearningworkspace '../main.bicep' = {
  name: 'machine-learning-workspace-basic'
  params: {
    name: 'machine-learning-workspace-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    storageAccountResourceId: storageAccountResourceId
    keyVaultResourceId: keyVaultResourceId
    applicationInsightsResourceId: applicationInsightsResourceId
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = machinelearningworkspace.outputs.resourceId
output name string = machinelearningworkspace.outputs.name

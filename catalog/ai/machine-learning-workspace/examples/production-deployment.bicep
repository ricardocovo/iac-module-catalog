// Production deployment of Machine Learning Workspace
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param storageAccountResourceId string
param keyVaultResourceId string
param applicationInsightsResourceId string
param containerRegistryResourceId string = ''

module machinelearningworkspace '../main.bicep' = {
  name: 'machine-learning-workspace-prod'
  params: {
    name: 'machine-learning-workspace-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    storageAccountResourceId: storageAccountResourceId
    keyVaultResourceId: keyVaultResourceId
    applicationInsightsResourceId: applicationInsightsResourceId
    containerRegistryResourceId: containerRegistryResourceId
    publicNetworkAccess: 'Disabled'
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = machinelearningworkspace.outputs.resourceId
output name string = machinelearningworkspace.outputs.name

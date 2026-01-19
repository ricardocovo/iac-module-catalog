// Production deployment of Machine Learning Workspace
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module machinelearningworkspace '../main.bicep' = {
  name: 'machine-learning-workspace-prod'
  params: {
    name: 'machine-learning-workspace-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = machinelearningworkspace.outputs.resourceId
output name string = machinelearningworkspace.outputs.name

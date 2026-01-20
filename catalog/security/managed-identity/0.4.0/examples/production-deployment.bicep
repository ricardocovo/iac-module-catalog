// Production deployment of Managed Identity
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module managedidentity '../main.bicep' = {
  name: 'managed-identity-prod'
  params: {
    name: 'managed-identity-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = managedidentity.outputs.resourceId
output name string = managedidentity.outputs.name

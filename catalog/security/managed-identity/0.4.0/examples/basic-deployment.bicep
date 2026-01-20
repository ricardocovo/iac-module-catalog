// Basic deployment of Managed Identity
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module managedidentity '../main.bicep' = {
  name: 'managed-identity-basic'
  params: {
    name: 'managed-identity-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = managedidentity.outputs.resourceId
output name string = managedidentity.outputs.name

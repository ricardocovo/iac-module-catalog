// Production deployment of Key Vault
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module keyvault '../main.bicep' = {
  name: 'key-vault-prod'
  params: {
    name: 'key-vault-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = keyvault.outputs.resourceId
output name string = keyvault.outputs.name

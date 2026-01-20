// Basic deployment of Key Vault
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module keyvault '../main.bicep' = {
  name: 'key-vault-basic'
  params: {
    name: 'key-vault-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = keyvault.outputs.resourceId
output name string = keyvault.outputs.name

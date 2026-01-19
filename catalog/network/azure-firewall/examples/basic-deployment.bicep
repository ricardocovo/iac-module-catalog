// Basic deployment of Azure Firewall
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module azurefirewall '../main.bicep' = {
  name: 'azure-firewall-basic'
  params: {
    name: 'azure-firewall-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = azurefirewall.outputs.resourceId
output name string = azurefirewall.outputs.name

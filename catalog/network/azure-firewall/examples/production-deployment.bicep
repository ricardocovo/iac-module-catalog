// Production deployment of Azure Firewall
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module azurefirewall '../main.bicep' = {
  name: 'azure-firewall-prod'
  params: {
    name: 'azure-firewall-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = azurefirewall.outputs.resourceId
output name string = azurefirewall.outputs.name

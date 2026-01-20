// Production deployment of Azure Firewall
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param virtualNetworkName string
param publicIPAddressObject object

module azurefirewall '../main.bicep' = {
  name: 'azure-firewall-prod'
  params: {
    name: 'azure-firewall-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    virtualNetworkName: virtualNetworkName
    publicIPAddressObject: publicIPAddressObject
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = azurefirewall.outputs.resourceId
output name string = azurefirewall.outputs.name

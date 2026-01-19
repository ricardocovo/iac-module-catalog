// Basic deployment of Private DNS Zone
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module privatednszone '../main.bicep' = {
  name: 'private-dns-zone-basic'
  params: {
    name: 'private-dns-zone-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = privatednszone.outputs.resourceId
output name string = privatednszone.outputs.name

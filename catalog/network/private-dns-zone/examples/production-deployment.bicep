// Production deployment of Private DNS Zone
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module privatednszone '../main.bicep' = {
  name: 'private-dns-zone-prod'
  params: {
    name: 'private-dns-zone-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = privatednszone.outputs.resourceId
output name string = privatednszone.outputs.name

// Production deployment of Private DNS Zone
targetScope = 'resourceGroup'

param environment string = 'prod'

module privatednszone '../main.bicep' = {
  name: 'private-dns-zone-prod'
  params: {
    name: 'private${environment}.internal'
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = privatednszone.outputs.resourceId
output name string = privatednszone.outputs.name

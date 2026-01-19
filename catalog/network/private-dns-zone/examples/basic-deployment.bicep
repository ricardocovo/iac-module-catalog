// Basic deployment of Private DNS Zone
targetScope = 'resourceGroup'

param environment string = 'dev'

module privatednszone '../main.bicep' = {
  name: 'private-dns-zone-basic'
  params: {
    name: 'private${environment}.local'
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = privatednszone.outputs.resourceId
output name string = privatednszone.outputs.name

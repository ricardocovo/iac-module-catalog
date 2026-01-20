// Production deployment of Network Security Group
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module networksecuritygroup '../main.bicep' = {
  name: 'network-security-group-prod'
  params: {
    name: 'network-security-group-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = networksecuritygroup.outputs.resourceId
output name string = networksecuritygroup.outputs.name

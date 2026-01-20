// Basic deployment of Network Security Group
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module networksecuritygroup '../main.bicep' = {
  name: 'network-security-group-basic'
  params: {
    name: 'network-security-group-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = networksecuritygroup.outputs.resourceId
output name string = networksecuritygroup.outputs.name
